# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.5.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.4/agentboard-darwin-arm64.tar.gz"
      sha256 "624e3ed70fc853249fe1a52fbe52eaacffc2c57920600356746b339d629b2e14"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.4/agentboard-darwin-x64.tar.gz"
      sha256 "7fb804df0577afbab3d0532fbd4e9e33020e6e258e84b70067ab674f0c58d66b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.4/agentboard-linux-arm64.tar.gz"
      sha256 "32ef46fec0512f27f208b65f948c6fdf135693305ad774b29587abef968240fb"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.4/agentboard-linux-x64.tar.gz"
      sha256 "7a21220cfc1299be137d54029c4d07a37552cb7a722639622188eccccfe4b324"
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
