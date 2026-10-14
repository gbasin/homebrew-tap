# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.32.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.32.0/agentboard-darwin-arm64.tar.gz"
      sha256 "dc4730610ae5e5decdbc6b860e98d5333b9496df58b484883389dc058cfeb29d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.32.0/agentboard-darwin-x64.tar.gz"
      sha256 "17cb99497e6ed93040a6fc5d75fcbc6ce0b5a1d0ca9f3aeda5d252ce13a94e03"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.32.0/agentboard-linux-arm64.tar.gz"
      sha256 "70ae80757d2645dd624660b523494fa7760fbb7222581990b2f614e37dcd2bef"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.32.0/agentboard-linux-x64.tar.gz"
      sha256 "dd7a921c49093e31e5e83393847811dc3d484eca39243710bd1713b305eec451"
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
