# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.34.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.3/agentboard-darwin-arm64.tar.gz"
      sha256 "d753d3107f5ffda792a725803573aa598f61406f11884f961eb551d6926375e8"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.3/agentboard-darwin-x64.tar.gz"
      sha256 "96ed0672a0ac5828c99beb7b965866be8456751340256bcccbf9f2f7af95d5c4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.3/agentboard-linux-arm64.tar.gz"
      sha256 "2d6d5207a67a6ec36b3025b08da8c1616732995d64e84bdf5514d811decdc5f0"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.3/agentboard-linux-x64.tar.gz"
      sha256 "0a283ed37e7b983cc2be1c4a61b1b9179a08363dd95e2419c3e0597f550be988"
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
