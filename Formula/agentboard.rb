# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.43.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.3/agentboard-darwin-arm64.tar.gz"
      sha256 "aa78977dfe9aa733b42f4c070fc2a2c2371cddc76f7f6e0fe756adc23184172c"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.3/agentboard-darwin-x64.tar.gz"
      sha256 "5758ff19e4ab3f8e3e8d0374aa5778ec98a34fa11cc6a9a37615aebb00d02b7b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.3/agentboard-linux-arm64.tar.gz"
      sha256 "3c7795c86d13c07fcbf7436cd0b0e5230f45b85be91ceaf45a295ac72d1ec637"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.3/agentboard-linux-x64.tar.gz"
      sha256 "6fc854ddb585165a50cdcf58d078741b38326af8410a2bc55e301a8cb6239a49"
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
