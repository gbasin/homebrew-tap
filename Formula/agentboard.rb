# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.35.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.35.2/agentboard-darwin-arm64.tar.gz"
      sha256 "604d999b259573f6ddf7876fa75cbf227e7fdc3bc4265a6d971050b5d622db41"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.35.2/agentboard-darwin-x64.tar.gz"
      sha256 "d284eddb566fabccab1814c92fa57fff21540bc7bd034487dc2f4d11bc2c6c90"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.35.2/agentboard-linux-arm64.tar.gz"
      sha256 "bb40c04c4c01f8fc82b0f17968804af9195d8dcaf4805da03c29a435f8b6b400"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.35.2/agentboard-linux-x64.tar.gz"
      sha256 "bf9b7cfe3bc49e8fb418c2fd2fd698bf717c7249be6f69b2164ae6f5159e95aa"
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
