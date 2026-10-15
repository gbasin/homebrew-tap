# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.34.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.2/agentboard-darwin-arm64.tar.gz"
      sha256 "81ba11685a34d061bd0489130d138fc2a2edcd8243b501851e7c1aaf815ce576"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.2/agentboard-darwin-x64.tar.gz"
      sha256 "00d537e0109c6f9e09e34285c9dd0a0dd927ddaa29a89523e177ea40976f0c62"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.2/agentboard-linux-arm64.tar.gz"
      sha256 "bb6e343bd53954d5e9b0886b8aca6e4c14f52c102c690b1d2d0e55cf7bed6fe9"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.2/agentboard-linux-x64.tar.gz"
      sha256 "b37a46d6bbd4bc5c0910142a7fbc2125ef412413f4402e629e9416af667f430a"
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
