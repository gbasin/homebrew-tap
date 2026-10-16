# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.35.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.35.1/agentboard-darwin-arm64.tar.gz"
      sha256 "944f93f2bc2bd017e573109f0c4279d0158daa4f849b151387b8f38184f79536"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.35.1/agentboard-darwin-x64.tar.gz"
      sha256 "b58db668d3759e2835ee4b453350d719be2374aa93583532c122ec8df1fd75ee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.35.1/agentboard-linux-arm64.tar.gz"
      sha256 "5189dcd5c5e24376c51ffb89276dce873ac0fd7782a5991230ab7afc513afc79"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.35.1/agentboard-linux-x64.tar.gz"
      sha256 "35c03c59cf9a3f8388cff17c6fbb9d2b5b1962ad57e4924e18f88a1ad26ce115"
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
