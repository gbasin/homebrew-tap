# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.26.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.1/agentboard-darwin-arm64.tar.gz"
      sha256 "5f7a9ca18afa41427b7da59c32b906ed31f323971b578e2298e5e610a0e4e74d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.1/agentboard-darwin-x64.tar.gz"
      sha256 "dabcd1f5cf8bb28cd4b2e96a4bc94f6510ade3484ec9c52a5084f1359a9fa6c9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.1/agentboard-linux-arm64.tar.gz"
      sha256 "f29072a8d0af398825dc91993a772dd86d762a79715b482ae5e955b759dbb6bf"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.1/agentboard-linux-x64.tar.gz"
      sha256 "a2416212294a78f9f01141cabfcb881e1d359a12e53aaf2548f17f969fe42742"
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
