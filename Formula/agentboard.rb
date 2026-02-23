# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.18"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.18/agentboard-darwin-arm64.tar.gz"
      sha256 "7321d2bac92153d8b55ae31767a795216982f404b6845c60c06ecc44ac0bdaa5"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.18/agentboard-darwin-x64.tar.gz"
      sha256 "75cc7902974a158c451325141162c000ca6339e8672f4c71078f8c3cb0914a02"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.18/agentboard-linux-arm64.tar.gz"
      sha256 "b55f3ada749336f9882e80e0cece0ef4c84934f422744735b7785b16d81acb07"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.18/agentboard-linux-x64.tar.gz"
      sha256 "d6625a65cc200f531498bb4f81a38df094017076768a4aaeec149813ac2a8e5b"
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
