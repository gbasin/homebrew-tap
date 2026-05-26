# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.49"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.49/agentboard-darwin-arm64.tar.gz"
      sha256 "c9c6c8540c2cffad7ce0d8032b786b5b268a9ba41217fb85e0d116cce84c7751"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.49/agentboard-darwin-x64.tar.gz"
      sha256 "c8e1939e2a983a037f1aa0b569dd00e16be7cde7576a23ae2e4553266e82bdc8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.49/agentboard-linux-arm64.tar.gz"
      sha256 "6c972167ad0bc6fa8d0d56fc117e4e60bf8154b3d98e3c1da9ab5c90eac4e6e9"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.49/agentboard-linux-x64.tar.gz"
      sha256 "fcbd79972beb98fd33a54239c9e4c71f0bc6bb8d389c393f78e409934821fdf7"
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
