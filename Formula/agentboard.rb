# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.24.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.24.1/agentboard-darwin-arm64.tar.gz"
      sha256 "271d3c2d0df421530f62f1f3ad89687ec2a466b3181b1eb04b82eebeb2d3d79b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.24.1/agentboard-darwin-x64.tar.gz"
      sha256 "bb12d4e20abd16d8cdbb08a7972b5377a986a1c670d3dff7cf2ed344a1c23bf4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.24.1/agentboard-linux-arm64.tar.gz"
      sha256 "b9c6a1f1d90cd4de6de8e1434abe48df043ca8975b387fa1cfff0fc75f1da8c3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.24.1/agentboard-linux-x64.tar.gz"
      sha256 "83f1625fc4db1dccd1b05d33cdd47c6b708a79f5f219595c44794e06b2309af3"
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
