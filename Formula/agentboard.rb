# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.24.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.24.2/agentboard-darwin-arm64.tar.gz"
      sha256 "55ae9f61cbf902d45ada4d43b1df87b7c26e7187d71e4c965ed6cfa6f33c3016"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.24.2/agentboard-darwin-x64.tar.gz"
      sha256 "14a7a6a617a304e474a89cebff7ac2648090882444086e64c6ca66ac0298feea"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.24.2/agentboard-linux-arm64.tar.gz"
      sha256 "4e846bf2522a34bb03166570f77e9db6425a1c4cb3b21104d8ad7eb2c47ee5b8"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.24.2/agentboard-linux-x64.tar.gz"
      sha256 "4972cb66e5c24224d6d85d014b25015924a556d6d6d0f3b827320b4084e51d80"
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
