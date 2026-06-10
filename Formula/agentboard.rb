# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.51"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.51/agentboard-darwin-arm64.tar.gz"
      sha256 "efb563d19bc131832fe5eba1d9e89b9f736986affd0631b179e76e6ca98dc78b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.51/agentboard-darwin-x64.tar.gz"
      sha256 "a21f5efd4f01640cd5ab24b40ddb904321c445b2a170e97f3fa74c7f7f2d5c78"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.51/agentboard-linux-arm64.tar.gz"
      sha256 "5fc390c7b09c29956806283b836a0abe04cea1c50288dfe55fa97ab73c9ffcb8"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.51/agentboard-linux-x64.tar.gz"
      sha256 "c98282eddfab9c77212f82ea4ea7a5560bc05fcbaadbd2276e39293296e558b7"
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
