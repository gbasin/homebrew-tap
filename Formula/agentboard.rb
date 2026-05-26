# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.48"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.48/agentboard-darwin-arm64.tar.gz"
      sha256 "f09017d67a71fb057b34a00ed55857fe8f8e4778714df9f354d04400e0ced8a4"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.48/agentboard-darwin-x64.tar.gz"
      sha256 "3a98bbe7052cb45425982e1f14405e3e9a660bee6f378d51b346839fa65f678c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.48/agentboard-linux-arm64.tar.gz"
      sha256 "bf4892e6010bdc5fd8594c0e9a0378d4d371b5d603b9a9572c54d0cfd18afc4f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.48/agentboard-linux-x64.tar.gz"
      sha256 "58d1e276f944e68a6c0d71dc41bc0b9ae5eba531919c36fe2d3b0eeb0ffac3a0"
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
