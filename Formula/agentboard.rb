# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.25.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.2/agentboard-darwin-arm64.tar.gz"
      sha256 "65ee803678d0fe1823317e8bdc88cad155b1d44091b0361de993e9acc6539c2a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.2/agentboard-darwin-x64.tar.gz"
      sha256 "88ca1d31b2ba171e7f95d15ac3ee6d1f09342c946f03cd86526513278fa36028"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.2/agentboard-linux-arm64.tar.gz"
      sha256 "dd319a6df28432e786142ddd8f210231430d08ff2231311f3482c8f5001ea6c2"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.2/agentboard-linux-x64.tar.gz"
      sha256 "8ea4b82aa519bb908c8dcbfca8541ea4eddb5bf34ebe44403b28e76bde0b411b"
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
