# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.7.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.7.1/agentboard-darwin-arm64.tar.gz"
      sha256 "8e2974dec7a5a4157fa5e41fc8a691ce70454bf71f5672934fd55dc1b989443d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.7.1/agentboard-darwin-x64.tar.gz"
      sha256 "ef77b83b1c230969045c6f30c6009d903ef1b7c796bfd5e16b007edf0c6fc9ea"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.7.1/agentboard-linux-arm64.tar.gz"
      sha256 "da30dfd64f72661d42ca316f242cb0ec340b12d30227ffb90c04b89db52c2b94"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.7.1/agentboard-linux-x64.tar.gz"
      sha256 "01d050fabc5f0e30fcd051a4b2171ac65c247390b0050eb38ac6cd47299280db"
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
