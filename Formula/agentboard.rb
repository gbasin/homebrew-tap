# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.26"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.26/agentboard-darwin-arm64.tar.gz"
      sha256 "a2fcd88f7e6552f70379289a531c7d02027a86a81c4ffc91a986e55dbf6c9c21"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.26/agentboard-darwin-x64.tar.gz"
      sha256 "cc552667215643dc707c4b78341c1e181635c8504d4680347abb86c753d271ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.26/agentboard-linux-arm64.tar.gz"
      sha256 "0623f3287e8f5716f5ef98a20b33876017396a7f706f79bcc92c91e60b5b3d4a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.26/agentboard-linux-x64.tar.gz"
      sha256 "4121e52e50c9c86d93eed08c0a51681312d1fed4723ca6002727f73c6f4ecbb4"
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
