# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.45.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.45.0/agentboard-darwin-arm64.tar.gz"
      sha256 "56238600ebda3a730704570143766a00bf53eb537b540623fd906e37f778296e"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.45.0/agentboard-darwin-x64.tar.gz"
      sha256 "a321c998f7d4b6b240de33367d945da2fd3d11fbbbcc3246ee9b26b209ae6f0e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.45.0/agentboard-linux-arm64.tar.gz"
      sha256 "38b3b56fcaf47211810a00694e4ea1876abf2836c647d13f977f2a3d0a1126c2"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.45.0/agentboard-linux-x64.tar.gz"
      sha256 "1903fc62b632cb212c4d3cd96dd068013d161108d743dfd9f91ac80d106d8ade"
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
