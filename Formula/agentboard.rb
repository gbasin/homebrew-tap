# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.12"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.12/agentboard-darwin-arm64.tar.gz"
      sha256 "50d3eeb190661ec180ec16f6f8664c76da32a6bb584072e4fee2dd26c38d167d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.12/agentboard-darwin-x64.tar.gz"
      sha256 "3b79a531b9f9a2fe793ea9a4978d523044a71c9c3ec09cdedb9973f8756aefab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.12/agentboard-linux-arm64.tar.gz"
      sha256 "255e13f1a5907aef327110bde06233aacd5aeffc0b98d17f6f557b40ebf13993"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.12/agentboard-linux-x64.tar.gz"
      sha256 "bd739e5f04c905b42869aec4f3fc93215655043c7815ef906132d8084b6bb190"
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
