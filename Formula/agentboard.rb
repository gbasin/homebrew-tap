# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.16"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.16/agentboard-darwin-arm64.tar.gz"
      sha256 "9b73332568e92bd561a9c6ecc258ca34995b2c043dfb369d20b7ab86b802219a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.16/agentboard-darwin-x64.tar.gz"
      sha256 "ca52f08a7eafd9984c04f8101473b85e7cc0074195cd0fa04d5601d0e9a849ce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.16/agentboard-linux-arm64.tar.gz"
      sha256 "28616474b3f933715d79870cdb62963d88d3bf5d81aa228177c6f4c96bfc2f21"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.16/agentboard-linux-x64.tar.gz"
      sha256 "f121b238992b0b684cda63c96bfc7d42d891ef0d3abfd3e42b9ca0dd80445838"
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
