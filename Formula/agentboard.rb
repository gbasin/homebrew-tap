# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.7/agentboard-darwin-arm64.tar.gz"
      sha256 "7212baeb8384cb19a822b02138fdb316f41593e3af5114e5f2762609ba3f4689"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.7/agentboard-darwin-x64.tar.gz"
      sha256 "41cbc26c0934e3f9368b1728fcaa6f2ea07b686682938228bbe197e70212b228"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.7/agentboard-linux-arm64.tar.gz"
      sha256 "60040241e11a4bbe1e7eb6fd881f664b06235898fea8e519b51ea0b7e4d83358"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.7/agentboard-linux-x64.tar.gz"
      sha256 "5cd7227fc39d100f49868290926c90d1608d737293ca9145bbf8e1f0b03f14f9"
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
