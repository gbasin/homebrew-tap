# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.0/agentboard-darwin-arm64.tar.gz"
      sha256 "08fd443e478a1aa0363a963a9204a52a9412c20c876e11d5b4923081e3bb0c0a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.0/agentboard-darwin-x64.tar.gz"
      sha256 "6f88fd45097033299ac86f0efd8db525a6bf2aaede3a9df7f3c03d18be0430e9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.0/agentboard-linux-arm64.tar.gz"
      sha256 "9482a85aca0a3b6d094efb551f3770249113a7d03d9a7973dd1430815dd67af6"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.0/agentboard-linux-x64.tar.gz"
      sha256 "5100d960de3315f39e431d4f42191bee73f69593eff507529666e3451ac84767"
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
