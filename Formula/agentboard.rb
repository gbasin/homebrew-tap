# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.1/agentboard-darwin-arm64.tar.gz"
      sha256 "561a1857f4eb8db79bb5613d35fae63ceae16a84ffee58a045d7401263719510"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.1/agentboard-darwin-x64.tar.gz"
      sha256 "87d656cc81d073376f4df9edab01c8d7e1216a485e38367c234b7d4205bdd032"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.1/agentboard-linux-arm64.tar.gz"
      sha256 "c1475b9965f17cea93b26bd5a1b54c1d413f8eb5a5c69fac91c29366f0438f1b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.1/agentboard-linux-x64.tar.gz"
      sha256 "60cf8177d23088c84549e3a3a6754d93a4c314f55c84a85c8c8beaf4e5978302"
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
