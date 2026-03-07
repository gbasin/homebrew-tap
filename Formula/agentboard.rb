# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.21"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.21/agentboard-darwin-arm64.tar.gz"
      sha256 "9f566f6133079c05ce365b64d67a30d65ac71e58ec38945456e14b4deac69f22"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.21/agentboard-darwin-x64.tar.gz"
      sha256 "bc2c3b0fbe21cb81ba4c05a775966b7731a020d293d442d7c12393b6639c1e53"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.21/agentboard-linux-arm64.tar.gz"
      sha256 "2c5740d65a326b8ed7715e9fa76ffd35db862d31522b61f15fe39d96102fe897"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.21/agentboard-linux-x64.tar.gz"
      sha256 "352723b51ed780b1471429f77ededece6e321d7b915ba8b6d792dbb812358613"
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
