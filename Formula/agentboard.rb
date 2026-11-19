# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.10/agentboard-darwin-arm64.tar.gz"
      sha256 "033b7c4e2e106df98378c0397b7a3f924477700736cfe1fa82dd2d0bc0e61c66"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.10/agentboard-darwin-x64.tar.gz"
      sha256 "bb0042baf1326cbc9045a92b0c86b0af10a3a0863c1de133fdb5444479b972fa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.10/agentboard-linux-arm64.tar.gz"
      sha256 "c437758e5707e1afa50af08c297a10576967cdddd969ff6784d944a243b16df4"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.10/agentboard-linux-x64.tar.gz"
      sha256 "6af60558e3c05ff290732f5efa8e34a82376e25dcfcd96512db522fb10ae8916"
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
