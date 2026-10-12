# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.28.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.28.0/agentboard-darwin-arm64.tar.gz"
      sha256 "d77fc17ff894e4bb08894ee40832200e65b749de0024a85817fd9e95b2e6a520"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.28.0/agentboard-darwin-x64.tar.gz"
      sha256 "bbf08f963f6f043fe1c2d17364cec02b8f0a67176c2b616ededf8a141687928b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.28.0/agentboard-linux-arm64.tar.gz"
      sha256 "a8089b0d7164c1e822503debda7666c65ff8828fdb83938398e39626ed0c0749"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.28.0/agentboard-linux-x64.tar.gz"
      sha256 "cab17726642851889f846931e6b2a5cb469285d3e1cc5807ca559a575287c778"
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
