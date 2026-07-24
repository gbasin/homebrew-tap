# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.5/agentboard-darwin-arm64.tar.gz"
      sha256 "73555e966dc4ec50307d7b1833e96e73ed82b0e46530119effedfb96887f3af7"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.5/agentboard-darwin-x64.tar.gz"
      sha256 "a3ea34cc96c33cd6b3f60cc1ee40b27dbeae92ea5bcd5d83e37268cb86d443a6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.5/agentboard-linux-arm64.tar.gz"
      sha256 "c8ee7256b75410805430120b04e148343279a9109201337ae6ea7345ad659358"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.5/agentboard-linux-x64.tar.gz"
      sha256 "0d0c3cdd29bbd37df423830a1257bc129dc3c53f83a4ead2b31958aaea558c57"
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
