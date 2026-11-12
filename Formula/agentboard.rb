# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.4/agentboard-darwin-arm64.tar.gz"
      sha256 "e0a2f2a90105da83c8be5b1c26710a881273408d32eb51129915847bfdbca096"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.4/agentboard-darwin-x64.tar.gz"
      sha256 "0017a2c37388de53454d590b73c3625bb80c0f39f121d0fa034afb193be707cb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.4/agentboard-linux-arm64.tar.gz"
      sha256 "15d3569fb3fc33f554d412fb3fc47545877ca00b666a320e0e5c0ca34bda5520"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.4/agentboard-linux-x64.tar.gz"
      sha256 "516611450ebaf88374ab4cfbcd244efaed747db49b002945742d8fcdbd3731ee"
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
