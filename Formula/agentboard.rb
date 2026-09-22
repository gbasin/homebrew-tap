# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.11.0/agentboard-darwin-arm64.tar.gz"
      sha256 "acfe661528727fa4a5aad7c79a779871cef49b308034eee0504754e5befdd800"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.11.0/agentboard-darwin-x64.tar.gz"
      sha256 "eb0929163ff203de467cd143f361c86468073bc779c358ee70ca3fc22f011163"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.11.0/agentboard-linux-arm64.tar.gz"
      sha256 "d043bf8a4aabcc58abf9dbc67cf017b2ede3c15b4e25e00524c545572b91c156"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.11.0/agentboard-linux-x64.tar.gz"
      sha256 "a5ca62a841653d1ea68d3bd2fe6a7abcf33672d44328bbb3ec5737e0c5747b86"
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
