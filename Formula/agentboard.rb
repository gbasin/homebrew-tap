# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.48.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.1/agentboard-darwin-arm64.tar.gz"
      sha256 "0c1fd25bb9f1dc39cef627cb52b00267340c4b7fa682125c517ba6a75f5cb053"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.1/agentboard-darwin-x64.tar.gz"
      sha256 "4d3bc3c07fe81b2ae971553854a5bc88da3a487ef4d126da619e8538298248a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.1/agentboard-linux-arm64.tar.gz"
      sha256 "9e1b2e20859985d71b22bfbf1662f62e0fce1a20bf717dad97e66c80230aa5b4"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.1/agentboard-linux-x64.tar.gz"
      sha256 "17a4030c7b4c2ab9631e9f7fe6abfd4d322b028ae049d5b21c25fc9ffede0375"
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
