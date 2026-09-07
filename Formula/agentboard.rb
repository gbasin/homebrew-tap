# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.0/agentboard-darwin-arm64.tar.gz"
      sha256 "e1076c3402a8a43a7c85ff93d163c5e59be76ca9831cdfc3188e9a96af9bc4f9"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.0/agentboard-darwin-x64.tar.gz"
      sha256 "98342ba91df6e4f239f59234b1a9c009b4a189a4b007ef5217308f22a6ac74da"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.0/agentboard-linux-arm64.tar.gz"
      sha256 "d11052c9baa779c8064fa955dc26cf8353392192098743b6fa8ae69228beb099"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.0/agentboard-linux-x64.tar.gz"
      sha256 "5ffb72bf6cc62f1bf340e414c77f52eff1b632fa7df094b426032027ebad37cf"
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
