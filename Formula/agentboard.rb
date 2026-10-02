# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.23.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.1/agentboard-darwin-arm64.tar.gz"
      sha256 "7f2582047c5ecff6c68fb4d858b6978f40d61180e6dbe60c5e388232531956ad"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.1/agentboard-darwin-x64.tar.gz"
      sha256 "1ea2381c49f216415ec934f7a8b6bcb48b296ce1907c98d5917a1f9ce4942ed2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.1/agentboard-linux-arm64.tar.gz"
      sha256 "277f21c1f4ddd8d0ce1cc4f7257e710383850b91fc84e0af8161827d18f9bba1"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.1/agentboard-linux-x64.tar.gz"
      sha256 "73ee029af14c51d3c6028ec8725438197d5e43194010dfccceffd16b5d190af0"
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
