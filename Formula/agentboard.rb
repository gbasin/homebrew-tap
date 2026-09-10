# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.5.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.1/agentboard-darwin-arm64.tar.gz"
      sha256 "27660d954fc0e2cc988038540a9e0bf8cc14d3ab24e523c50868727afe6380d3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.1/agentboard-darwin-x64.tar.gz"
      sha256 "e5b304f1a4b236b9e15c62d1959b2e4ee170e93353fc3ccba09d62c2650efcdf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.1/agentboard-linux-arm64.tar.gz"
      sha256 "713c901b8968f1b75ae03ccb833378716e7ba4874642aef6b5f2641881276f75"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.1/agentboard-linux-x64.tar.gz"
      sha256 "ad128e793278b4646926771cba7e8fc0c028c28019b5790f01fb2c670dc9e6d4"
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
