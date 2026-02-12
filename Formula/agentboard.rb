# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.5/agentboard-darwin-arm64.tar.gz"
      sha256 "77728dfbef24afb425b75b7bb78fa410d079b56f54dd7992c0ea7f9ae261b60b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.5/agentboard-darwin-x64.tar.gz"
      sha256 "e9d37896a835caf199d1263af799fe0b33ed5a4ff1f8628020fc7e86f8c770ec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.5/agentboard-linux-arm64.tar.gz"
      sha256 "9e172ef82be28342b7c3cf82344b5c38ac25a04bbc9ba0162b63b8b46339bfda"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.5/agentboard-linux-x64.tar.gz"
      sha256 "23821a6e9616dd3ab8c6f6bfa4662c35c4c86ea6a4fa9b24d9426ea2b3b085ed"
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
