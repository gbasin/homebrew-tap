# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.44"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.44/agentboard-darwin-arm64.tar.gz"
      sha256 "3894bd14c83dc2319fbe477a5cc0fea2422ca8606668ffc305f97d18c6cdd5b8"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.44/agentboard-darwin-x64.tar.gz"
      sha256 "25cf2ddc5741902b804de3d7e10075cb00ebf0bb44e7d714a4dd1bfa76fb11b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.44/agentboard-linux-arm64.tar.gz"
      sha256 "029a1258e739d3c0cb03039f31584f4ab0efdc10f9d439747c243826455796a7"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.44/agentboard-linux-x64.tar.gz"
      sha256 "aded065bd1d3d28b0bf7e9746afec145e48ae04a2eadda13c51a37931c7aedb6"
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
