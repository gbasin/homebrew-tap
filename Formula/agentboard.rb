# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.30.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.30.0/agentboard-darwin-arm64.tar.gz"
      sha256 "3ef34810113ef988b22c5a0185e2b8df82b73f78e94d4a67d02532f2b8ed1351"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.30.0/agentboard-darwin-x64.tar.gz"
      sha256 "7dc5e4d77002809c8872e7b3442a182f53693d551071a0569afc5d0740ac9cb8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.30.0/agentboard-linux-arm64.tar.gz"
      sha256 "d09e453dde6bd669987e91578eb6bbb0b957bf3895c60121b9ea7dbe3c5d189d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.30.0/agentboard-linux-x64.tar.gz"
      sha256 "7e80bf34061504b9e994d78ae7b53988e39c06b06594ba0381c692accb08b61d"
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
