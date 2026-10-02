# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.23.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.0/agentboard-darwin-arm64.tar.gz"
      sha256 "af405eb7a0ff4cc34c0f461dbb57afd492290225517f779426911e99730a45d3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.0/agentboard-darwin-x64.tar.gz"
      sha256 "b8a2ede7f9b70bee09cd0da9511be13816cf1af3a7937fa64d7ba351ac1ce4d8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.0/agentboard-linux-arm64.tar.gz"
      sha256 "3b01c7cf3e9574f0482c063b4dea5d2145fea91a307d89de63373dcbe949e1ad"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.0/agentboard-linux-x64.tar.gz"
      sha256 "e617f3387d79def8d67101b992ce8feb38eae5fdca6064d4c25f9dfc87cf320b"
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
