# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.6.0/agentboard-darwin-arm64.tar.gz"
      sha256 "f113bd351d09df4c8809be6a3769853eda0290bd7d705f37e498aeb03f41473f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.6.0/agentboard-darwin-x64.tar.gz"
      sha256 "8fa6e2ad75b679ead3f186a99a4b043d48fd06935bb4f411985d89d1057bf0d4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.6.0/agentboard-linux-arm64.tar.gz"
      sha256 "d02f98c25d3588189ffb63d77a6f7c8fb81b205a57403f2bb3333ef1384cff38"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.6.0/agentboard-linux-x64.tar.gz"
      sha256 "64b4bab1a4cdb6cebd4351180b93e07a3a902a33519599edbf5f3e567ca47aab"
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
