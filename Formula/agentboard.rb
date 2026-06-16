# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.2/agentboard-darwin-arm64.tar.gz"
      sha256 "d308e95fabbc7577ec2af138b04faf1f19bfdd4813c6100ac04ba12bd1ea29b1"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.2/agentboard-darwin-x64.tar.gz"
      sha256 "23a6f52240621b7335459b66b4fbb48ada76db7786931934fd9a9b58da9c13b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.2/agentboard-linux-arm64.tar.gz"
      sha256 "a01963db05a0b93e569bfd602e6c15fdef310e0416d6a24fdf1645ce7c0e408a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.2/agentboard-linux-x64.tar.gz"
      sha256 "3341c643ebae1975294aade5593e60f2f3b21035c608784f903546aadde8320c"
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
