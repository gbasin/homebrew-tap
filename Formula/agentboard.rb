# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.19.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.19.0/agentboard-darwin-arm64.tar.gz"
      sha256 "4130dd8999ea16d36a61a234b1093558df4055db4ef0cc366a66f3f99f6b61c3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.19.0/agentboard-darwin-x64.tar.gz"
      sha256 "46379a0085f59e7a9474bb763008d5ff52ed2e5b2ac12edd872d766ffe17041d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.19.0/agentboard-linux-arm64.tar.gz"
      sha256 "3df0d9c2c6fb54fe0ed5a95f39ac6d4239b460c0879d5851d5963c8a12bd14a3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.19.0/agentboard-linux-x64.tar.gz"
      sha256 "ece95df3d67c302ed2accfc553510fdb81796ea5487afa89f3e696ca32f97ea6"
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
