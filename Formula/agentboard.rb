# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.26.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.0/agentboard-darwin-arm64.tar.gz"
      sha256 "3b5d51cc3527a844ad63f6b5bcdf34fe6cecf0581f7448525e1adb95cdfe4e0c"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.0/agentboard-darwin-x64.tar.gz"
      sha256 "650ecbd66b92b994522fd0e9aff3afa79557d075bca7c7cdf3fb43d1e2b32086"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.0/agentboard-linux-arm64.tar.gz"
      sha256 "d5910c3a2080c15d85946d9830ffb08e4eba1098ddf6cce8d3e015b7ef19c4a1"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.0/agentboard-linux-x64.tar.gz"
      sha256 "d78a49eae4fa242609141b20cc0ec783c0344e3adac55c708b46432375647eb4"
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
