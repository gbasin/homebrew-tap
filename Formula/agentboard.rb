# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.3/agentboard-darwin-arm64.tar.gz"
      sha256 "d6d400b5fae7ca8f321e0f805e6018f78b5b1bd407a236119c48dceb55d4b3ad"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.3/agentboard-darwin-x64.tar.gz"
      sha256 "f30e4da77043a4d80bc9097464fc782e818c53fe7962343cf526cebbfa41d929"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.3/agentboard-linux-arm64.tar.gz"
      sha256 "8c944fc0ce6e21f6f50679add69c17279510ed6c5a4dd464dab16d0d1f83af64"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.3/agentboard-linux-x64.tar.gz"
      sha256 "cf37b8d3fc7b3e9a7307bb13d0e76d2bbeb2ba6e9dc9a54acff3af7cf4ced340"
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
