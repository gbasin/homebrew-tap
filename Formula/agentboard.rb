# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.31"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.31/agentboard-darwin-arm64.tar.gz"
      sha256 "2645cacfe241d1e7735ab7b8d76a219f0a8a7727b0770b73d6ee93dac3399e81"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.31/agentboard-darwin-x64.tar.gz"
      sha256 "d9f4bc723c04f3d34336911d02977801033364743c32587475f8a809f4d02373"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.31/agentboard-linux-arm64.tar.gz"
      sha256 "8e91b879171fa6b859d44b0368118b251ec954cfb75abff6afd198891ed62db0"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.31/agentboard-linux-x64.tar.gz"
      sha256 "2fb9ff02e83e67a14250811f3c120e7a26e3c75c760e4524f1b2b4e51cd8e5d1"
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
