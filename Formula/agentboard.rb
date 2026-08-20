# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.18"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.18/agentboard-darwin-arm64.tar.gz"
      sha256 "8d6e6fd1d04691f4891d449571722aa74e961b6625bfa8cb5dd3212d6f03bede"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.18/agentboard-darwin-x64.tar.gz"
      sha256 "b3ab48ebed5edc777cdc5d3099f19dee3e654b7322b65eacdaf1c7ab32e9746f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.18/agentboard-linux-arm64.tar.gz"
      sha256 "52ab506cd61e9534d4ae89f56969e8e1cdedd93c02baf1841a158fc29ed1ebd7"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.18/agentboard-linux-x64.tar.gz"
      sha256 "b54ff609fe2abca03a550ed6966cdd1b167d2fe81bc362750534a87ae128372e"
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
