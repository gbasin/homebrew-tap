# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.12.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.12.2/agentboard-darwin-arm64.tar.gz"
      sha256 "82bc0994704eda7ffba655dbe68cebd229bb6cb4f6834cd5690d8ee2ed576bfa"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.12.2/agentboard-darwin-x64.tar.gz"
      sha256 "90f99ba4b90f48cf19386561c46773aff628bc73f70f04573ec5cb653d6d7252"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.12.2/agentboard-linux-arm64.tar.gz"
      sha256 "90e0d3ca69672bc0cfc90dbb0e45b956863e6f2ae7e79991426b39fa330d9ab3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.12.2/agentboard-linux-x64.tar.gz"
      sha256 "92749d7dc0d60f7cf9b95fcf2283f5c0809a0be1d241d8f128404c249e0fffd6"
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
