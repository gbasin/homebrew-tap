# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.28.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.28.0/agentboard-darwin-arm64.tar.gz"
      sha256 "d2abe5df204133d34946071de5a25ee374ab76fb5a5355ac31cd9ff3a18778b5"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.28.0/agentboard-darwin-x64.tar.gz"
      sha256 "b73aae41300f1db94a4cee7f9cd8d5b4f821d7cf62b5ca09fcfd82f580335738"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.28.0/agentboard-linux-arm64.tar.gz"
      sha256 "3cf1f7f69b0014f74fa86d6b053f480d7ea44f11f6d1d64d3a04d6a5f3d1b2a9"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.28.0/agentboard-linux-x64.tar.gz"
      sha256 "4fb3aa5f4f5d03ef4af4ec0ed5093dfc3696e18d50d8d883ac96b2cbaee4e06a"
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
