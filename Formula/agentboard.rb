# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.6/agentboard-darwin-arm64.tar.gz"
      sha256 "6145066529c0a65cbcafdf335ffa740c9a48951d4db52e95d178c0754a386022"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.6/agentboard-darwin-x64.tar.gz"
      sha256 "14996c0eab21edcd026a0244e5baafec5a2340bf2132a41ab3341eb681bd70d6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.6/agentboard-linux-arm64.tar.gz"
      sha256 "5d4c69b12ad23433e9e67bedfd663c490aeae871afef2c20712cd2e6ff0f9f9c"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.6/agentboard-linux-x64.tar.gz"
      sha256 "63ed56c31591f02c010bd29d630963f15dbd8f24b4642efeb59d2dd463f82068"
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
