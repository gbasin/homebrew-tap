# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.31.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.31.0/agentboard-darwin-arm64.tar.gz"
      sha256 "8b62c89be83c924b00fb6ce69640b85bf0ed3ac621a9aca3750ffb5a408b1b35"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.31.0/agentboard-darwin-x64.tar.gz"
      sha256 "b6f6def15e0bd857a02242b07d523e3820e1ee238a61ed7410163b688b5e6777"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.31.0/agentboard-linux-arm64.tar.gz"
      sha256 "41fbb133a9a6af3291d1280da4354ccc811f2bfc06f050107ff22dbc1ce2d06b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.31.0/agentboard-linux-x64.tar.gz"
      sha256 "4fa3212b6b77670d0f822e3d8917e067f7a01ca1094f19dbb667945ff9441a1a"
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
