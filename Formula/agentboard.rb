# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.36.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.2/agentboard-darwin-arm64.tar.gz"
      sha256 "6b5aeb3911c040c5f21b768fc0bd19271f241ccdb6ff58550b794685099283af"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.2/agentboard-darwin-x64.tar.gz"
      sha256 "b4c9d38c0de475af8ffe6a5e5c29ae183ce393343051cbca782da175e8d1695b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.2/agentboard-linux-arm64.tar.gz"
      sha256 "837e3c57387de6f75c16672ed422b76ef487eaa79b73cb85a156543b27c43599"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.2/agentboard-linux-x64.tar.gz"
      sha256 "afc7a395597e00c5eb393c9ce044bbb9c7da1f8838bd9cc2cf34198822956524"
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
