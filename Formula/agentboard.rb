# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.47"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.47/agentboard-darwin-arm64.tar.gz"
      sha256 "77e8311f9c229f25154a995aec8ad11ab47e44897dc5617b44a6d07ac55304a5"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.47/agentboard-darwin-x64.tar.gz"
      sha256 "587f3c7c47e274ed2200159263d6200111674968f94c379d37cc4090488c9d67"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.47/agentboard-linux-arm64.tar.gz"
      sha256 "50cfc6d93be3f6ed0e9516bdc1ccbd3e1709fe043317c33a5ba933c66cc8bf3f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.47/agentboard-linux-x64.tar.gz"
      sha256 "7d799adbe975d29c96f61a54ea27b61f2c035d494dd8dc2147bc10744dd96c68"
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
