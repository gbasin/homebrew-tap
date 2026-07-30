# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.7/agentboard-darwin-arm64.tar.gz"
      sha256 "1abcb9d324af90e0d5838576cb1a8368f0b97742de1120a252ab51d2e4e966d3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.7/agentboard-darwin-x64.tar.gz"
      sha256 "c8c39c3d971cfa6e957a0c72e49ba281b267fa1fec45108cb156e621f183cfb9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.7/agentboard-linux-arm64.tar.gz"
      sha256 "cd1981a2acf5106799317e08d1064a70034e3b1d3d87a6f86c4221905af7853b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.7/agentboard-linux-x64.tar.gz"
      sha256 "8d63c9f9f6f1b6a6133a84cc96e4263b41ce3a8282cdb8da69fd04f34a635171"
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
