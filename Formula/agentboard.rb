# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.0/agentboard-darwin-arm64.tar.gz"
      sha256 "5215ad9f6943a0bb451f6a1429ff6ff2910ca23067e78cd747c60665d52d97fa"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.0/agentboard-darwin-x64.tar.gz"
      sha256 "9e2bf7b95d4820a511e29064eaa3ddc711662f1bb825d1c94b57de4f6a27a497"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.0/agentboard-linux-arm64.tar.gz"
      sha256 "7d7cfa4858a17fe2197256c15f622b729b711346f72509c9731cbf86c174c26a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.0/agentboard-linux-x64.tar.gz"
      sha256 "55440a36f80ce03efc7026a928ca817956f0d14c3c0510716337c10d70768c2f"
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
