# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.12"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.12/agentboard-darwin-arm64.tar.gz"
      sha256 "bbc52765a6874fb81030e2e4c1f5e19cf315fb22da06b6a9526a380db0bea9d3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.12/agentboard-darwin-x64.tar.gz"
      sha256 "8c68be9a5bd3f544eed564b0c14e59f68018c5634a01c76f0484b6bf3742d496"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.12/agentboard-linux-arm64.tar.gz"
      sha256 "17cae2255e1e00e8e3a39b2ef847ec7cd45f5e0287e38cb37517450e917344d7"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.12/agentboard-linux-x64.tar.gz"
      sha256 "0fa368835a862cd9961b5a5d0025a507437d9891ef8811e50c2cca8b5b360f3c"
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
