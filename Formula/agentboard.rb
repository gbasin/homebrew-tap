# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.22.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.22.0/agentboard-darwin-arm64.tar.gz"
      sha256 "73590fb93e795ab02b0828c78db66d53f795a42595acb37381720e6d24f899eb"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.22.0/agentboard-darwin-x64.tar.gz"
      sha256 "22c41275fde110a11f5b30f41b86e982fc63c5be7c47e9e17d339ef9fdd6ff9f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.22.0/agentboard-linux-arm64.tar.gz"
      sha256 "5c56802163ac26f8f55aba840725c6cdb177b9ca7343d02987c3b36f58096332"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.22.0/agentboard-linux-x64.tar.gz"
      sha256 "5da8eac47467e4822c177ef8cc4012afd2241ca0d27f28d63fe885dc888dd32c"
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
