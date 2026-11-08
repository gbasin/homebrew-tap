# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.43.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.1/agentboard-darwin-arm64.tar.gz"
      sha256 "cd286a61335ff3de710d442ab73d08d5cb5d490ac005a2e619da21ceda6100b2"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.1/agentboard-darwin-x64.tar.gz"
      sha256 "e3a4ff254592cce62d535b89051df594961c6983e0d2c22265d414f0dfed9d64"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.1/agentboard-linux-arm64.tar.gz"
      sha256 "15488428df66e2b34b451d7ea5ed41dce3ca4e8a1b57a50ca725d8863594f41f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.1/agentboard-linux-x64.tar.gz"
      sha256 "1c3258fe62554987767cc54a9636e26dc0e892d035025c3f8d6588ff4117397f"
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
