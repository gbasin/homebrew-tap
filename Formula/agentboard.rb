# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.24"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.24/agentboard-darwin-arm64.tar.gz"
      sha256 "13a15f9cc2cb4c090cead246e4a7124064374e17f2d828b9d1d3deac524d3b01"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.24/agentboard-darwin-x64.tar.gz"
      sha256 "de760ee130fb2d368f3a05b62aafcf0e41290f386edd47496fd08771706f9114"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.24/agentboard-linux-arm64.tar.gz"
      sha256 "55e3bb89b3a611c40f480fe09d7e2a7fe04b879a8cede54ddfd1c4771fb0a047"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.24/agentboard-linux-x64.tar.gz"
      sha256 "b3302844edb563aa4bd47dc4fdbb6a54c495d9d3b4fe2525e636a479806612b9"
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
