# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.50"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.50/agentboard-darwin-arm64.tar.gz"
      sha256 "9ceac3e82d02ed2ce8787168b524a3055a7413dee6cea0e8387ac3335656718b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.50/agentboard-darwin-x64.tar.gz"
      sha256 "27c94700f255fe173a2ca0c78f98dd9c65329485f545844f37216063ad52af20"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.50/agentboard-linux-arm64.tar.gz"
      sha256 "d87d59ea7066222741350baa24492a77de5bf086e16d13a69809b045b1e10cf2"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.50/agentboard-linux-x64.tar.gz"
      sha256 "6f5dcc6379043cd0decd09bc28e746f60d1f65140f15957a40d885939c1c09fa"
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
