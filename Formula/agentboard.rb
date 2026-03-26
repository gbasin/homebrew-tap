# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.28"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.28/agentboard-darwin-arm64.tar.gz"
      sha256 "d5b65849b6ffa172497bbeafe57311b9a80ef347b1f73980879c814357b07e90"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.28/agentboard-darwin-x64.tar.gz"
      sha256 "4b2bcd4c9a603aa27c8aceaaa2f88efb777deed6b0e046d321dd53309cfa9252"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.28/agentboard-linux-arm64.tar.gz"
      sha256 "74f2cbc91bb3c465705b03663799f82dcce2a771c07630f5e62da3fc554af669"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.28/agentboard-linux-x64.tar.gz"
      sha256 "ddb39a20e2624204ec25bd185fa1857b4a5eed614fc7e6caa9241238cceec973"
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
