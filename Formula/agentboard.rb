# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.6/agentboard-darwin-arm64.tar.gz"
      sha256 "a2a8596f3200524cff4ecc9b3243a60a15356f07bfd58f899ccd3af6b15301f8"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.6/agentboard-darwin-x64.tar.gz"
      sha256 "6d09703730bb1a9449dbfbfaa3058f87433ca1a11de68c87d5a159c216c6255e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.6/agentboard-linux-arm64.tar.gz"
      sha256 "31d51af16043fb3602073d8b8caa67148a21fec80e3620b09fd39096274d7de3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.6/agentboard-linux-x64.tar.gz"
      sha256 "cc200baff064a9a696f511fc805b0598a027745be4d2fb9c9074fc6951138320"
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
