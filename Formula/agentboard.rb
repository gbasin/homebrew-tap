# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.19.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.19.1/agentboard-darwin-arm64.tar.gz"
      sha256 "82c2a93e5caea042c68491df03cfd0d33709e17ba72a5cc6eb5f11be9ae372a0"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.19.1/agentboard-darwin-x64.tar.gz"
      sha256 "309df845b84642fb804c23801b21adb14816b249e6ca5d1df232c4e1e6ef53e8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.19.1/agentboard-linux-arm64.tar.gz"
      sha256 "0a4e675eca9351cadaa7846887ed447cf1b1157094f5a026d3d30a43c5556872"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.19.1/agentboard-linux-x64.tar.gz"
      sha256 "2ff48976a8a42a8c5eb00284736f51f97e271478c89cd3469df0c8e9b4028fc2"
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
