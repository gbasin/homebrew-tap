# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.7/agentboard-darwin-arm64.tar.gz"
      sha256 "209b9f83437a6e0ae70b5db306894ef7b130ba8e4d953a4a9f15d609f3e2c189"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.7/agentboard-darwin-x64.tar.gz"
      sha256 "d6bead058b26872f3c8d5c6cef82c0780573bb619748f88539907ee39f390a61"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.7/agentboard-linux-arm64.tar.gz"
      sha256 "b1cad5585af01a903b9f4137f1be175c8e560896233acd3e5108b8af9eb97c71"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.7/agentboard-linux-x64.tar.gz"
      sha256 "b7989ef3b14a75adb2f322c5d8d2b70e17bf40b493cf05b73f00efa26fa6468b"
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
