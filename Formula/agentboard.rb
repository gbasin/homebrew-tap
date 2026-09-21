# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.8.0/agentboard-darwin-arm64.tar.gz"
      sha256 "959f5c7283630591e27c10f69596ed459b1a3cc1d133c2b91415718e04e25515"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.8.0/agentboard-darwin-x64.tar.gz"
      sha256 "052409aff1a0c0b80a245208c6e647ac616aaa0c0876094d4723fd0e3545f1f5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.8.0/agentboard-linux-arm64.tar.gz"
      sha256 "f0be4858e8d6faa0b83353386dd5f229889bd78d669e8bd7032de04b898b4eeb"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.8.0/agentboard-linux-x64.tar.gz"
      sha256 "0fbdb77c7c80f6e65fee2659d9c9fde1e03f1cf404a21b20b718b1eeb1a59536"
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
