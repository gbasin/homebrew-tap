# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.14.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.14.0/agentboard-darwin-arm64.tar.gz"
      sha256 "c13814b8056c3e275277bd8eda32891f2350161fc0c748717e53da5a9fa92c28"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.14.0/agentboard-darwin-x64.tar.gz"
      sha256 "5539f0b93b5f13dc78cd17d5c552318ff6e259902a5374c679d146066bda064e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.14.0/agentboard-linux-arm64.tar.gz"
      sha256 "95fc609634f08247376e19de5021d2394750017b8f3106f410921f7c5ea662ba"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.14.0/agentboard-linux-x64.tar.gz"
      sha256 "54c404a03eb6d6ebca0951df9836221e3614e78af5de47c69f2756cba611e322"
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
