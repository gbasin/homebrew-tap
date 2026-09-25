# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.16.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.16.0/agentboard-darwin-arm64.tar.gz"
      sha256 "f82b4aec2ba78fa3ce743c591582de33e226a8cb7ca19adb120378edc3dffa19"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.16.0/agentboard-darwin-x64.tar.gz"
      sha256 "6ef321c5284790c3cbd10038bc736b8b2077a0619f5c2402da3e08aea494f60f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.16.0/agentboard-linux-arm64.tar.gz"
      sha256 "0d91c87b1c6159a74f03583c403b16e6f647d6e22c6f8991d3b5391069f70ba1"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.16.0/agentboard-linux-x64.tar.gz"
      sha256 "09227a5c184b2ce529d540f71162b495e1c19be53fcee27052f7d31137178492"
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
