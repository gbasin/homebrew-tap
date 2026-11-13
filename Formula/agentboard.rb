# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.5/agentboard-darwin-arm64.tar.gz"
      sha256 "315f210f7f06429bcb9d647222f796e3e7f0ad1bbb04ace3879df4d097b10eb1"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.5/agentboard-darwin-x64.tar.gz"
      sha256 "820e9640a46702ec1e6d73dbfacfd473274f0324cd9fc232f57c6db0fe4bcfcc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.5/agentboard-linux-arm64.tar.gz"
      sha256 "30812484e6e08632c35fba5f388739a7fe74f3683a41caba3f114724f1213aba"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.5/agentboard-linux-x64.tar.gz"
      sha256 "4faa0b1b500ead6e6562cac2c7850156b9f086d5890008099262b76350a15650"
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
