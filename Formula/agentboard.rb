# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.0/agentboard-darwin-arm64.tar.gz"
      sha256 "7749c81baec493b88a0d1be840144069a565a9a91038d349286537f66dfa20d0"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.0/agentboard-darwin-x64.tar.gz"
      sha256 "b4a495c29dc05ed7b019dbaf03ec0e620c99cc1c999277764985fa220d2bcc05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.0/agentboard-linux-arm64.tar.gz"
      sha256 "943bba3236b651631071bf9cb53c97268177fca4880fa5526be7552de75d2006"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.0/agentboard-linux-x64.tar.gz"
      sha256 "fd12198671bdf0474d6761c7ce77248b847d7d6c40c2385dbac636b0fbbfadde"
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
