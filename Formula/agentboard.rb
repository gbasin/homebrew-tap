# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.43.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.1/agentboard-darwin-arm64.tar.gz"
      sha256 "310752a9393b172a51fe7475b1c48fe86aaf8335c1e29f0da34724dda67bcbc3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.1/agentboard-darwin-x64.tar.gz"
      sha256 "cf84dcdfe30f543130d1ce514d7b64655079d00f4ee9ab0fcd1806575f7a5c90"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.1/agentboard-linux-arm64.tar.gz"
      sha256 "ddf94bc3a829c58a91c8916dbdb69f054f598ce41af3ba12ca7edf7de441520a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.1/agentboard-linux-x64.tar.gz"
      sha256 "198a1039f28b888d5f03939ba73678543d38640ea2c7dd4f2f18b296abece1f8"
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
