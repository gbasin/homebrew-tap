# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.29.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.29.0/agentboard-darwin-arm64.tar.gz"
      sha256 "17abd7041c5c136c11d4b259e480e8b14dcf184c3100d23c8a1e1419f2b1d299"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.29.0/agentboard-darwin-x64.tar.gz"
      sha256 "2bcc044888c98971acc4e2a46a133a9935df704c44d4c17a055736e62e3c1407"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.29.0/agentboard-linux-arm64.tar.gz"
      sha256 "4fff103089a3306ae04275e142f5a1292142a0084e04732a5baee1a50bcd428a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.29.0/agentboard-linux-x64.tar.gz"
      sha256 "c8d1067c23a0cf0aa95504fe701dac41f44431c87c8765a0c07acb108987ad3d"
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
