# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.27"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.27/agentboard-darwin-arm64.tar.gz"
      sha256 "6db4b11b1fc76b00b7ffed58ef1fdaee2173ddbef94684c9a0f9766cd2a02dd1"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.27/agentboard-darwin-x64.tar.gz"
      sha256 "18862fd5094a44e4733b30f45856372394dfd12f97030331a0dfe1e2c3a6a2fb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.27/agentboard-linux-arm64.tar.gz"
      sha256 "8c878be1cf743bb22b41b919dd910f612c1d6e8b94d18615e1853b4f9265ccc0"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.27/agentboard-linux-x64.tar.gz"
      sha256 "64530601f5b1149760bbda70c82bc549a845429355591332006ef342aaadf087"
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
