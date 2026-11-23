# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.47.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.47.0/agentboard-darwin-arm64.tar.gz"
      sha256 "f405eaa93e64cf33b7b5b404a2fdc234620dfa1e3a257e2fe832b54d6f5ad181"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.47.0/agentboard-darwin-x64.tar.gz"
      sha256 "2f2bb8a82c46b5ca1a8aea052431390432651f30436a7f3b4b275eb1fed15412"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.47.0/agentboard-linux-arm64.tar.gz"
      sha256 "7cc173614a0cd0db207ce9db0ddb7d2d1344a50642da30fd3f7d0fdeccd8c661"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.47.0/agentboard-linux-x64.tar.gz"
      sha256 "9e89d5ba99bfd41cde83e68d62c7d9b0367633240e698badbc8de6b28b4e4ec3"
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
