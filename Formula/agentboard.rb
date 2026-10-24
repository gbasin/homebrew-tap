# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.36.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.3/agentboard-darwin-arm64.tar.gz"
      sha256 "c1c1463f85693feef08895003b7a6fca33dc9dfe547ce4b23c981bdd90e18496"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.3/agentboard-darwin-x64.tar.gz"
      sha256 "26c4bcc33c31eef342f078fd454c050518844d7607a75efc9a8682ac81080adf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.3/agentboard-linux-arm64.tar.gz"
      sha256 "33950ba6647bf875319e9ee046e21f689ffa35895a794bb952e01c45152f70fd"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.3/agentboard-linux-x64.tar.gz"
      sha256 "0007af3cc6bf42174d6dedc50f3d4e49c4077d976ea030210af1f6e0a0f4f64a"
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
