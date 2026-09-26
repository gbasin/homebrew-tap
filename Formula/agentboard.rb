# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.18.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.18.0/agentboard-darwin-arm64.tar.gz"
      sha256 "0e60799671af0e74c1632ce72c3e1061437b2aa46cb87807b5f529f06bcde2d1"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.18.0/agentboard-darwin-x64.tar.gz"
      sha256 "05cdceb4e50cba2aed354594ce6fe028abad9e952c6636bceedf9923f0cf767d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.18.0/agentboard-linux-arm64.tar.gz"
      sha256 "f5f55a6c17309e7e8e195d4a46323e4a079a9c84d3c659399461b2628af6ae78"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.18.0/agentboard-linux-x64.tar.gz"
      sha256 "44f350ae9f9336b4b9440402f98d54632b7b537371f7e145b5b5e992c85b5aa7"
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
