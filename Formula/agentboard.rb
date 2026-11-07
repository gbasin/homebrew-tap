# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.42.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.42.2/agentboard-darwin-arm64.tar.gz"
      sha256 "0255d3ccadd3bf4a5384c3d744ef65292596ae98f13fbe2933aa880d36c8dddf"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.42.2/agentboard-darwin-x64.tar.gz"
      sha256 "7e959e9aba41a63e9ca30ed42e4e55063f209a34e69d10dfae02e98bcce339a4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.42.2/agentboard-linux-arm64.tar.gz"
      sha256 "6c8cc67eaa93d2a3e0a612f9c1d5556bb3ef7cf123e669bf62b1098ee48311fe"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.42.2/agentboard-linux-x64.tar.gz"
      sha256 "fd453ade3a74fe036249614995b41b45495a7b8235ea00f8353dad83730a129a"
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
