# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.38.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.38.1/agentboard-darwin-arm64.tar.gz"
      sha256 "ce0bb1db3468be30eec5abb44ec986ac56d598342b05790a52d5c1321e70469c"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.38.1/agentboard-darwin-x64.tar.gz"
      sha256 "f2ddde25a70ce89451c04bebe70997bffe1bc48c3f5dfe658835f53c00e5cad7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.38.1/agentboard-linux-arm64.tar.gz"
      sha256 "d70880729738eff8d5860203b35e6efbf22162d4eed02f2e5830ac146fc1547b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.38.1/agentboard-linux-x64.tar.gz"
      sha256 "a01bcfb1c96535990c47766d560c5dc9e14fab5ff879d04fc359899cbe1bba5f"
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
