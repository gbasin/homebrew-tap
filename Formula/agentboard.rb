# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.23"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.23/agentboard-darwin-arm64.tar.gz"
      sha256 "f5317dc5d253a29968bc42a38b1fed9b08af3fa6516955598c5a18c45fad91c0"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.23/agentboard-darwin-x64.tar.gz"
      sha256 "e902a0cb054487f931a416f903f59c2de3f234a8ea05a1095efd1f4b482f66f8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.23/agentboard-linux-arm64.tar.gz"
      sha256 "af214e3ba9e24e8b0e8e0bb362e6e93dc81733e9cb132892184bedf201be22c3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.23/agentboard-linux-x64.tar.gz"
      sha256 "dc0b2e1f1583e02068aee46dc3fb9127fd38f935a7b85f0c0d10e58749ecc262"
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
