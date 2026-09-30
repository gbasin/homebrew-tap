# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.20.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.20.0/agentboard-darwin-arm64.tar.gz"
      sha256 "d6ba2c3929fc147078fdae09f4567788f098585c8a1a9b69599b7a2e94912a16"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.20.0/agentboard-darwin-x64.tar.gz"
      sha256 "f75c066ca0684102f706412ca27d1438655d5a241978cf71ebff0d36842deeab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.20.0/agentboard-linux-arm64.tar.gz"
      sha256 "51d4f5961ce08b672f6f4bfcbea794fbe994a87d9691abdd773814f6d05f0be8"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.20.0/agentboard-linux-x64.tar.gz"
      sha256 "1a5cc23f87cabf0f592ab9a10b5359547ede41ab3e8f990417c5f410d885b1ea"
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
