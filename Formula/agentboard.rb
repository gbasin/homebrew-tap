# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.5.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.2/agentboard-darwin-arm64.tar.gz"
      sha256 "93f663a3e48bb9cfdbc5eeada9309891ed461086a5ffd0c747391b9e11a296a5"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.2/agentboard-darwin-x64.tar.gz"
      sha256 "4aea05254ce183e305cd0bdb5620162c3442c135d0ef83eb5e7cd91e1e067c7c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.2/agentboard-linux-arm64.tar.gz"
      sha256 "44c6302e6d3d55fca5cf8a9502164eeccfc6c9accadbe398526b7b385fb95728"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.2/agentboard-linux-x64.tar.gz"
      sha256 "829dd022c74758e0663bab6dba6d75fb1962020b241cd56b8e8a718cb3ea0912"
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
