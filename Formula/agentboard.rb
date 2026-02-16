# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.8/agentboard-darwin-arm64.tar.gz"
      sha256 "23380b6d671d34e4952adc2205258f67b9b61ea696fbb55c7bb9f0b04da9e8de"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.8/agentboard-darwin-x64.tar.gz"
      sha256 "45fc150609ee4c87df49b68fa27390777faa501e88ccf9a6c3f8a74e30d42070"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.8/agentboard-linux-arm64.tar.gz"
      sha256 "e13d5679abd477b3dc387a21600eaddcb4667fc4918491f2f938f98a4e91a467"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.8/agentboard-linux-x64.tar.gz"
      sha256 "9b8abe0be0d3d77181393c21178b931f2e5f3f57e94fc7a07264e4f7ac910329"
    end
  end

  depends_on "tmux"

  def install
    libexec.install "bin/agentboard" => "agentboard"
    chmod 0755, libexec/"agentboard"
    (libexec/"dist").install "dist/client"

    (bin/"agentboard").write <<~SHELL
      #!/bin/bash
      export AGENTBOARD_STATIC_DIR="#{libexec}/dist/client"
      exec "#{libexec}/agentboard" "\$@"
    SHELL
    (bin/"agentboard").chmod 0755
  end

  test do
    assert_predicate bin/"agentboard", :executable?
  end
end
