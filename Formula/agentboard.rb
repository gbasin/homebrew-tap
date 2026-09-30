# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.21.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.21.0/agentboard-darwin-arm64.tar.gz"
      sha256 "1fcfdcb61c9d419b96af1d4428d8531741e1496e68033044bf117afc96031d2a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.21.0/agentboard-darwin-x64.tar.gz"
      sha256 "283681b9c6aca9b34f60a9c9b9de201da8ca40be6f62d6daaabe9bcd53fc5b74"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.21.0/agentboard-linux-arm64.tar.gz"
      sha256 "61bba9fcda5c472eb969bdbc1c914347d3ecb468532813edf2393d40c69092b2"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.21.0/agentboard-linux-x64.tar.gz"
      sha256 "168de450090e9ce93d526c507104a816032d253c4294bd9885e4be9a6b793a89"
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
