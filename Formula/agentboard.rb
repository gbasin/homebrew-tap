# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.21"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.21/agentboard-darwin-arm64.tar.gz"
      sha256 "44d44fa6bcc2666208aaae2c5b52de9229f82e58ef42154bfea46367b4dc9230"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.21/agentboard-darwin-x64.tar.gz"
      sha256 "f6fa756431d4a8bff96ff1098cfe0aabf2ea833d6c95b22a3f0f50c88fc75a90"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.21/agentboard-linux-arm64.tar.gz"
      sha256 "95274ee5ac5bd4c189bebc216a8a1b506bf7bcaa7857758c38f6097d5f547284"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.21/agentboard-linux-x64.tar.gz"
      sha256 "96c8e1faac1481f69d20f5f4e3e5db2e5b4283284fdd83c2efb3d93305fa1391"
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
