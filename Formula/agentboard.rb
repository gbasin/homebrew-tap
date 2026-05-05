# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.46"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.46/agentboard-darwin-arm64.tar.gz"
      sha256 "fa8f1cfdd6594f5fd94f94392e1d01d2a2446ac5a75af0e7704d42093fda5fe6"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.46/agentboard-darwin-x64.tar.gz"
      sha256 "cd81f7ae5592b4313ccc299f667cd84143359dce5899720ae53279ac8df77276"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.46/agentboard-linux-arm64.tar.gz"
      sha256 "7f0da10accbecd5cac3eb9c100f8e7d95a65602541e37024ce49636d951aa7ff"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.46/agentboard-linux-x64.tar.gz"
      sha256 "c5285abf90726e6bb3b26a654cbb6f703ed0b9c237a3ba4047c80e4b385b4628"
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
