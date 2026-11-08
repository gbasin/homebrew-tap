# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.43.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.0/agentboard-darwin-arm64.tar.gz"
      sha256 "afd01cc9fee3065b5fbb70dd00d320d7c12e789f101fbcada60c87a86a1fce3d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.0/agentboard-darwin-x64.tar.gz"
      sha256 "bdc003991f4783e9543c69a9e132123ac0ed38dbaa1afce3630fb768a6dee4e0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.0/agentboard-linux-arm64.tar.gz"
      sha256 "2d6bcd9b27ebbebf5f10c92ee3c752f89a19d66a7b3dd896fd4c2b3de93d7d85"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.0/agentboard-linux-x64.tar.gz"
      sha256 "e8a1f709365ea7126d0a202399dfb351f838669d3b9eb3e7ba7502491c3ac51f"
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
