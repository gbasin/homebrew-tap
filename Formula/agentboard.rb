# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.14"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.14/agentboard-darwin-arm64.tar.gz"
      sha256 "540b7ec07f476773f32302131a769c1f1efe19035e9197ed985ef5f27199bede"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.14/agentboard-darwin-x64.tar.gz"
      sha256 "f98ec69334b962e527af3e6a8fcf4fbec917fe1a6b4c3c26ece1714e55c6f111"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.14/agentboard-linux-arm64.tar.gz"
      sha256 "cdad8dc2d9640355a775ffd0f736fccd4eb52efd59768976cd626efd25e85170"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.14/agentboard-linux-x64.tar.gz"
      sha256 "145c23a3071e826699a4b758fc5653c6d1d1cc533ed27e9c4fc542ffe3defadd"
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
