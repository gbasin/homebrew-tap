# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.37"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.37/agentboard-darwin-arm64.tar.gz"
      sha256 "c5b1b9bfc1c7e79d6c96edacec48065f27b857513c390d94870342e69472a73b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.37/agentboard-darwin-x64.tar.gz"
      sha256 "71245e80ccc17c37d729dc50736008ea62b2a43c4d3af2a96714a8e7a5ce0a51"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.37/agentboard-linux-arm64.tar.gz"
      sha256 "1ad100f1ccb0cb91286955ad8e7322b21a95c863aa4fa7162235f5e0d8146d3a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.37/agentboard-linux-x64.tar.gz"
      sha256 "1d6952a56011e62cb195a02efb2284a37ac796e58241b160a624415e9d05d5ee"
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
