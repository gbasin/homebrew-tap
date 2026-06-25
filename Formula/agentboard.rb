# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.1/agentboard-darwin-arm64.tar.gz"
      sha256 "e25014d194be8095cccadf54425be471883d04024231557a13f8c60498edcf75"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.1/agentboard-darwin-x64.tar.gz"
      sha256 "c99a6d321b314cf55835759d1ebb931ac808dfd10b38c16c0950789748d9871f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.1/agentboard-linux-arm64.tar.gz"
      sha256 "5af26a86c3f8894790cec008269af1aab8ac9c504dc4ac6be9c6cd0c042c684b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.1/agentboard-linux-x64.tar.gz"
      sha256 "c3830a5c24c4e89bc0de4514d297bd4d838bc4432f3924910346b8c4d9e3a420"
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
