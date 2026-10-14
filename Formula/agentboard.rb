# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.33.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.33.0/agentboard-darwin-arm64.tar.gz"
      sha256 "dfa4d8519952301d253719f3407d4267eee53fea0919367a049a66a0730a4718"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.33.0/agentboard-darwin-x64.tar.gz"
      sha256 "3187a9e7748996a719422e129077d4c3af8b8cfd7b2ccb2a3eccc4e9c744659e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.33.0/agentboard-linux-arm64.tar.gz"
      sha256 "c92959bb7a1fedad2956a71802702d7fda77b7c2890553e9cb27cc2db2b0787d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.33.0/agentboard-linux-x64.tar.gz"
      sha256 "089bf0a607fc8b678945828f9b27501b1b6c48ccf953561df889adab89c3d65c"
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
