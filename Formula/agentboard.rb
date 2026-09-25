# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.17.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.0/agentboard-darwin-arm64.tar.gz"
      sha256 "5a36b34d88c96e0aa9928b12edb57090caef187e69c269687e05bf2a5c369bb9"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.0/agentboard-darwin-x64.tar.gz"
      sha256 "b68da95b2000ae7f91f870b57c22881c07b4b10094beca2bbb970b31d3529ffb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.0/agentboard-linux-arm64.tar.gz"
      sha256 "54a40f2e63904f97cd6eb8280a2a51241fb907fb3790dd6317fd76ca573d0420"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.0/agentboard-linux-x64.tar.gz"
      sha256 "82e20d264c8b3ea17904fccdd92751a4cb6e2303732a454454091d4882f0d2c0"
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
