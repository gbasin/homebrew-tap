# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.3/agentboard-darwin-arm64.tar.gz"
      sha256 "5b9f0ddd8cfef9eb607a8f32c24bcbc7b5d03d996f6b0565ce3d3da61d208598"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.3/agentboard-darwin-x64.tar.gz"
      sha256 "7275fc72fc078c6802c5b2e6de34697cc6ed14d7925e54d872b703f78f8c321a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.3/agentboard-linux-arm64.tar.gz"
      sha256 "03207655e7500d28e946af16e28b57bd2e11e67c278960630521a95453a35873"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.3/agentboard-linux-x64.tar.gz"
      sha256 "c7b5f6de12f40aab92ce8af36176d2c6bc50317b4e3dc5767fa61fb3f49085d3"
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
