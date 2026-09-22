# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.9.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.9.1/agentboard-darwin-arm64.tar.gz"
      sha256 "e5b13019125e867a8fe5d91ab04e58b9157075cddf1c475b50b7f3bd2140a934"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.9.1/agentboard-darwin-x64.tar.gz"
      sha256 "c2d4f34944f3fee358893840172a1fb5999c105f7c0c8922f4bc46505109ab5f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.9.1/agentboard-linux-arm64.tar.gz"
      sha256 "168f4ae5882311e721276fcf965f8ce97c212794cc85aa1a48a6c30632862ca2"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.9.1/agentboard-linux-x64.tar.gz"
      sha256 "696cd15dae28cffead4d7dcb169e36179d6fa3c7a2c9336835165fa44b5a58f4"
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
