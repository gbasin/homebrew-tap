# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.34.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.1/agentboard-darwin-arm64.tar.gz"
      sha256 "f19cac3ae2625a6f26c321f929d9b95a65d651e765b29ffbb4947e301cbf1ec8"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.1/agentboard-darwin-x64.tar.gz"
      sha256 "3e5d946a6128c1ae784087384e7d583231be8e6f3d5d4181ddd85ca219ffbc32"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.1/agentboard-linux-arm64.tar.gz"
      sha256 "bcc3c168619b1956a7e2de2343d48db5e6765814265ecf0e0b3342de0281ae21"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.1/agentboard-linux-x64.tar.gz"
      sha256 "1711d2e310767349a133e864f8e351b622c925a108ce324674f0674d327943bc"
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
