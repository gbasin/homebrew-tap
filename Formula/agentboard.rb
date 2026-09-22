# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.12.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.12.0/agentboard-darwin-arm64.tar.gz"
      sha256 "edddc1d919c908d97bfbf058278750c7a320f6c79175c743bc5a291e063f6fd2"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.12.0/agentboard-darwin-x64.tar.gz"
      sha256 "c21b6112353d1dd5126fe9e2145071bbf41001e3091a08161c047ca379a9bd96"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.12.0/agentboard-linux-arm64.tar.gz"
      sha256 "78c12fd116ce9a0da137bb9d1b085ba3f59dbfe410a547dda97b961018bf098f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.12.0/agentboard-linux-x64.tar.gz"
      sha256 "18ad59eec20e8708d02d63ab33d6d9bd00ae9add2810b8922ee29fee501e9a2a"
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
