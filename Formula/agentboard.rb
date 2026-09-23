# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.13.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.13.0/agentboard-darwin-arm64.tar.gz"
      sha256 "40174ba4ca6576e70b823ef26c0613f87166a928743fe19fc0f88bff65eece6d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.13.0/agentboard-darwin-x64.tar.gz"
      sha256 "e6760d2910364c9a3b3495b5282ff5066a7041e5396fe1dc42c27c699ac59b3a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.13.0/agentboard-linux-arm64.tar.gz"
      sha256 "032a3db187fd552f36b1c364eb5e65ce35dc238339ba3805f108ef6f244faa9d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.13.0/agentboard-linux-x64.tar.gz"
      sha256 "af442b9d17596650f4e4f182641ab473530e2debcc889dc3594e228529c84000"
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
