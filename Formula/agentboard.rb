# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.22"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.22/agentboard-darwin-arm64.tar.gz"
      sha256 "42554fd8001eed073e591b5822fd4fca99371945051091f62eff64592bd16675"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.22/agentboard-darwin-x64.tar.gz"
      sha256 "57f65f892606d4974119bdcbd83681cbd4c90a7c457d66bc5a77d5cce2f4bbdc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.22/agentboard-linux-arm64.tar.gz"
      sha256 "fec315e70991aaeac968a2ec3505670d51b473f2fa71baedb32ea21fe4d48c9f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.22/agentboard-linux-x64.tar.gz"
      sha256 "1a9dc1803315378bce547d2b554b82b90509889c85a1460f4a4cddb25c78a39a"
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
