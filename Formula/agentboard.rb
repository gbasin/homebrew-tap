# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.34.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.0/agentboard-darwin-arm64.tar.gz"
      sha256 "a333f411aefce445560b0177e05c1dcf55b74e9e65d68d1bf4f44bdee1a3a590"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.0/agentboard-darwin-x64.tar.gz"
      sha256 "fe6778d50ae5aa7e108fa9340dcb14a08e4639c69a67fc97f954c46fb8e53f99"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.0/agentboard-linux-arm64.tar.gz"
      sha256 "629b239344c9a31c02f42c58db48f1d565780f1f547fd714ae1e9371284e406b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.0/agentboard-linux-x64.tar.gz"
      sha256 "ee82589a8aa8b8fa51afde127812742d42fd1e373e3208a58d498c7ad918badf"
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
