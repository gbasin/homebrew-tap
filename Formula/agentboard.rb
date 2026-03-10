# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.22"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.22/agentboard-darwin-arm64.tar.gz"
      sha256 "d4522550df7ed5a5b050c3c6f6c2461bda1726f59a83b472499151067121ca7e"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.22/agentboard-darwin-x64.tar.gz"
      sha256 "77aac3056a2123fd600277a67908a06b1d9d6e04b8503220db9621f9ed39ae32"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.22/agentboard-linux-arm64.tar.gz"
      sha256 "6f3b1d8d5287eb05882008bce59a107f1ec171a1d3b6bd8cde8e82265b4432f6"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.22/agentboard-linux-x64.tar.gz"
      sha256 "e8e9eb97bbd5f6a625a4d35ab67b82758afc86f96fcae8c68f254a54044dbb7f"
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
