# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.44.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.44.0/agentboard-darwin-arm64.tar.gz"
      sha256 "13a0f7c5212cfa00f148cbc136f34057ff4743f32c3e50895366209b04e8a16a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.44.0/agentboard-darwin-x64.tar.gz"
      sha256 "2be591f605c24e1bf3fe353bf12cb4b34ff395f0673fa83f75ffac82988ba645"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.44.0/agentboard-linux-arm64.tar.gz"
      sha256 "79eea91240dcf8ba15115fa8dcfed6df5f30d98c086dd45b6c28b6fc8d4e9c24"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.44.0/agentboard-linux-x64.tar.gz"
      sha256 "5aa52d8b8b67e0dd568fccd6d454384b9d2d49626c533d02700490815ac360f0"
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
