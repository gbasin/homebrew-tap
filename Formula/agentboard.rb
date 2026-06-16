# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.3.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.3/agentboard-darwin-arm64.tar.gz"
      sha256 "2cef8a39c9837b947235ad0b2f67ca84ddcab73a01c3c79a17ea3fab4eba8123"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.3/agentboard-darwin-x64.tar.gz"
      sha256 "73be968556a7033c03754864fd35825f1a74c095353e7eb3d731e75e261b9d58"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.3/agentboard-linux-arm64.tar.gz"
      sha256 "9ddcd1823ecea864964aa24c14fca78fd67fc11090b19d703fdcdbe2f6563f29"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.3/agentboard-linux-x64.tar.gz"
      sha256 "4daf064e662c770251b867c5426523e9bd26d51794da9b0e6c6c0cb8a454ec03"
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
