# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.1/agentboard-darwin-arm64.tar.gz"
      sha256 "17c79a60a53215be4083e6178807c85b23469124dd7ea1055903df93a80d3a32"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.1/agentboard-darwin-x64.tar.gz"
      sha256 "50e22e16d85d7d7d2c464d85d06f0cf9a67c29e95a13d1615a0a9ab8d8c0d41c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.1/agentboard-linux-arm64.tar.gz"
      sha256 "0d3237df313d09f45d1cbe70892df190b81662b90214422cf81574fdbcc58522"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.1/agentboard-linux-x64.tar.gz"
      sha256 "8b2c9353044516631624efba981cf8fa2e87452af536e99a4f2550f162424a0a"
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
