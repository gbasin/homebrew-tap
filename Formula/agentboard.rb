# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.20.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.20.1/agentboard-darwin-arm64.tar.gz"
      sha256 "14384e3b682988f500576d6aa86d1300bec1704ed6c78991ba48ce6a61dbe930"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.20.1/agentboard-darwin-x64.tar.gz"
      sha256 "d1a5c7ccaff03633547ddd7fc2834ae91059715b007c0c9e7cd923648dcc6297"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.20.1/agentboard-linux-arm64.tar.gz"
      sha256 "8e07bff9b97fba333c9c2cf16cd87b78e63e4f3aac9713f23f055e392b5327fe"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.20.1/agentboard-linux-x64.tar.gz"
      sha256 "fd48f0f3d0dcf4c4d90526733514df9829bb7f51eb1d2a529cc3236591cb6b6d"
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
