# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.17"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.17/agentboard-darwin-arm64.tar.gz"
      sha256 "a5995ae8e6f8386ac130f9e15fdf7d53f892838e2441ac326cd75f4210a88438"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.17/agentboard-darwin-x64.tar.gz"
      sha256 "83b076c896b168378547487f04143358b2a712f383593cabe7560f078912840f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.17/agentboard-linux-arm64.tar.gz"
      sha256 "00d848c5006c85ff0cfd7376b4419245a6f685aaf8e94b5dce5d91680c69dd8b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.17/agentboard-linux-x64.tar.gz"
      sha256 "82fc7dd5dc0a99f94cee0e7c2f0626b7bfedd5e1aa6a9b739b00593737aa305c"
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
