# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.42.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.42.1/agentboard-darwin-arm64.tar.gz"
      sha256 "ca00afa5263cfa9dff411a51e5ed70ea56388024dab4a49444a33ed7b10224fc"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.42.1/agentboard-darwin-x64.tar.gz"
      sha256 "f18ed47eaf88e7a7d17200c056ef2fa227147881490db96c1c1b58f985e4ab5f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.42.1/agentboard-linux-arm64.tar.gz"
      sha256 "e36aa5d697950a1c38e1fca907d5d7a2d3aacdc7579e70ef4194ed1d2ad46d08"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.42.1/agentboard-linux-x64.tar.gz"
      sha256 "289e15dd7eb1fe80dd47ee4494258da4e1f85207427c8b1be6df06d52364ac9f"
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
