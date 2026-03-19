# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.26"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.26/agentboard-darwin-arm64.tar.gz"
      sha256 "352541fa627f008949899e12d322de92f768ce648e980de0c9e95f83c89bcb0f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.26/agentboard-darwin-x64.tar.gz"
      sha256 "039df590276021d742c20ddf85c5647100a64fad65d3ed62357b2af91572f0e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.26/agentboard-linux-arm64.tar.gz"
      sha256 "65e19a59254b625d953d02166c2866fcf590de9c3064f8b4ac702eae3161e6d5"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.26/agentboard-linux-x64.tar.gz"
      sha256 "8e2d4dcc1fc2ef642464cd5f93b86e531bb7eb594be2815ba908dfeb89385f2a"
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
