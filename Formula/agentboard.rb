# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.14.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.14.1/agentboard-darwin-arm64.tar.gz"
      sha256 "1ea4b01121c87c1c3f0123886be76967311436e1e7be306a5d2d59b7ed634ab8"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.14.1/agentboard-darwin-x64.tar.gz"
      sha256 "8917d7debe7f029ad3bfc099bff706b8a47775f2aeda19bcf00233ffd41d3d54"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.14.1/agentboard-linux-arm64.tar.gz"
      sha256 "d548aedd915477dd46240272018c4d0bc08e133d1837ccc85f741cc06b0af8ff"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.14.1/agentboard-linux-x64.tar.gz"
      sha256 "2183abac325558985fb9ce0203fc29485eebec575a171cafb502dc02b085789f"
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
