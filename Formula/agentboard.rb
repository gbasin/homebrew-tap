# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.36.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.0/agentboard-darwin-arm64.tar.gz"
      sha256 "feeb7543c31a1c7f9791c9178791f415b564d23774b45c760f7265c6206fb9e4"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.0/agentboard-darwin-x64.tar.gz"
      sha256 "f3e45e8fefc133674c606b61cc5bfe8d18285d95aec425259d41cb08aa44abe0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.0/agentboard-linux-arm64.tar.gz"
      sha256 "f7029b26ed9e32d0b58191850efeef51d19201e812eeaded6e562fd51392c000"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.0/agentboard-linux-x64.tar.gz"
      sha256 "b6d1117aee850d147bc2794aa27e2abbb23d067473384bd46906adbce35418ac"
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
