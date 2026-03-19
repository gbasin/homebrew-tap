# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.25"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.25/agentboard-darwin-arm64.tar.gz"
      sha256 "e5f403bb5beff274faba0fc25f487d0dd3cd6ba187ef0d74b9298db5ba74ee17"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.25/agentboard-darwin-x64.tar.gz"
      sha256 "b1f7f4271b129d7ee210894d1fdaadee596f6634ef433a5c7ab148b84f6da296"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.25/agentboard-linux-arm64.tar.gz"
      sha256 "0ba76a6f7903973a412c5742f8f4a5d52c65168463717eeb8f1b5f3a9324f996"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.25/agentboard-linux-x64.tar.gz"
      sha256 "3ce2c401942789d5e5422d3d29e9c833ececc8165e33526f0060e269ceef6904"
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
