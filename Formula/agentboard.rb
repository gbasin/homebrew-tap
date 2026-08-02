# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.8/agentboard-darwin-arm64.tar.gz"
      sha256 "c8085a5ee16f223a81911ef52a2d0385e8567c0056307cf2f5de4e36954b3e89"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.8/agentboard-darwin-x64.tar.gz"
      sha256 "0c163da74bc3e974f66427046fc856811eb1aa7de95df93ecafa446381cee2a9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.8/agentboard-linux-arm64.tar.gz"
      sha256 "3f735f6ab29be351da3de44a9ed28fdd352112b5061eea6ee36adb05d89a794a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.8/agentboard-linux-x64.tar.gz"
      sha256 "152087355d292eb870c1fe8da353a01e243a5f31963c55ec5c5e7968083d016b"
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
