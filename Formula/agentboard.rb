# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.28.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.28.1/agentboard-darwin-arm64.tar.gz"
      sha256 "9d905aafba1f621c20d24267dc9f6aeb1f2883c26f5c62d9dd3dd0c103fdce1c"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.28.1/agentboard-darwin-x64.tar.gz"
      sha256 "c074bcbac340f645be323436f446f1da775879adf81f869d279c1f86f9f1bc33"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.28.1/agentboard-linux-arm64.tar.gz"
      sha256 "a2fba526281b93fadcda1badf005d48203a682454cfa9b2275600ddb836a21a2"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.28.1/agentboard-linux-x64.tar.gz"
      sha256 "25c80daac9d93e01fbd2c97ecad403f90f990538805fa0ccaead06fdd80b1280"
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
