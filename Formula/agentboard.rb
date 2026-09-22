# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.10.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.1/agentboard-darwin-arm64.tar.gz"
      sha256 "380dd811b32476444ef7977f517d5cdce1cbdb4bf1aec398824239e7d9a42490"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.1/agentboard-darwin-x64.tar.gz"
      sha256 "20535ed0894c9f93fe7464e0890a694f695439e2800fcdb3b198e9ab307cd3fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.1/agentboard-linux-arm64.tar.gz"
      sha256 "ced95af089a53fdf480549a94ffbf701584dadb8e00740087b327e1d59331b22"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.1/agentboard-linux-x64.tar.gz"
      sha256 "6635763695895e95c8e03049202e34541395a31ae1dde181e443535bca69b5fc"
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
