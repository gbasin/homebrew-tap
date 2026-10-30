# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.38.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.38.0/agentboard-darwin-arm64.tar.gz"
      sha256 "d9cc70460e0d5ceaf2f76028d4c270b42b5830d246466da1b128cf5d467950ed"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.38.0/agentboard-darwin-x64.tar.gz"
      sha256 "4ee001287b10319304713caa388e5fe14ba388f4cc80e26ed849d5c7d2a0de18"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.38.0/agentboard-linux-arm64.tar.gz"
      sha256 "abfb92bdd0003683d9640212d09447319b10a4aca383c1a0768e910b83492368"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.38.0/agentboard-linux-x64.tar.gz"
      sha256 "165d7d6046efb73665547c7b99a5d0b080ac1ce64ea01af77c90661975d59e89"
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
