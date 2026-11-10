# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.45.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.45.0/agentboard-darwin-arm64.tar.gz"
      sha256 "806cb0bf2b58bdc932d3e2d0d168598269bdd317f41d2c7064bfb1a1915230d5"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.45.0/agentboard-darwin-x64.tar.gz"
      sha256 "1e30ebc176d835ab6afa1ff6825016ddc8a572606af87f73ed020e27ee8c6711"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.45.0/agentboard-linux-arm64.tar.gz"
      sha256 "e9dc8e43d5773cb77a63f5433a104e6138560408fd039f1a191a43efa1c37836"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.45.0/agentboard-linux-x64.tar.gz"
      sha256 "abea375b7e7d6d9c49985a4dc4d976e9665fb92be03e1f06fe11b0c2d0535fd5"
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
