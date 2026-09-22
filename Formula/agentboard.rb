# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.9.0/agentboard-darwin-arm64.tar.gz"
      sha256 "bf03e8998bc8056d72a95a884732bc7058b4a592d6dda7bdb5dfe1e2471cb985"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.9.0/agentboard-darwin-x64.tar.gz"
      sha256 "d98a803aa8acf2aaff7011039eb4e1b8584f62b4da08f8acb8f86b09b7f5d7e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.9.0/agentboard-linux-arm64.tar.gz"
      sha256 "b0f43c6716f7a837bea70c0ba412c2023f116bd35b3b0f4e30597811d87e95c7"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.9.0/agentboard-linux-x64.tar.gz"
      sha256 "d38f34e4047317d8621668dbb5d1c17be523b5bf1d856a2c58b4b954c2fd9f5f"
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
