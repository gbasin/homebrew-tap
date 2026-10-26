# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.37.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.37.1/agentboard-darwin-arm64.tar.gz"
      sha256 "7e845f176dce0727a7b5651df034d02e1a23e84252abe28fb5adb80b3d1d62fa"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.37.1/agentboard-darwin-x64.tar.gz"
      sha256 "7f6d5d6e289d6abfa19f5751fdeb5ad9743eeb8fca3712af1fe3e2331e3c2760"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.37.1/agentboard-linux-arm64.tar.gz"
      sha256 "63c7d3e3ec74006394d2d51974d4a2309d66a28687eeb867db7c0b396fe9c917"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.37.1/agentboard-linux-x64.tar.gz"
      sha256 "7115d745d79735f3f6632bcbfad34b0d699d3b86f5115555aa8fc66b32069b59"
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
