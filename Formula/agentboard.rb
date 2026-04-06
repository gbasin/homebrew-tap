# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.38"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.38/agentboard-darwin-arm64.tar.gz"
      sha256 "ee7d756d9aa14a442f59874aa4f0853bc2d64ea00820aecb50960b72937f8efd"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.38/agentboard-darwin-x64.tar.gz"
      sha256 "dce9b74935fd11fbe3f308952cede1c9799bf5d7679b2588e6e6a0734f227233"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.38/agentboard-linux-arm64.tar.gz"
      sha256 "a7808a01311aaa09f8249af14d622efa0eda30fff0a54f14e2d28c69fd393218"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.38/agentboard-linux-x64.tar.gz"
      sha256 "98cd3238d9b6fc982cde3197059773c9809296f5f1fcf5c2927de3da9e392814"
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
