# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.9/agentboard-darwin-arm64.tar.gz"
      sha256 "c22f3fcc2b628fbf835653530bd7ce65e5e68b8a99b7cadd40cbb67934e07c4b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.9/agentboard-darwin-x64.tar.gz"
      sha256 "eee6f9fe556f6cc540e2ed5cfef7d33c3105d3f080886a71435b2253b7d9fdfb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.9/agentboard-linux-arm64.tar.gz"
      sha256 "789015e0e88eb69acbba5891f5fcfa75243a3455f7f4710acac6f1a5d05a5aba"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.9/agentboard-linux-x64.tar.gz"
      sha256 "0539e0b867704406fa8e5134b8b749d8fe1c4b055dd70eef387ebaa2ec0301c5"
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
