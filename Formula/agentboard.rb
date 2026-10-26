# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.37.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.37.0/agentboard-darwin-arm64.tar.gz"
      sha256 "62a5a98d7bd355d197506dcc27916feca1c2a6ac98840b612a70dee40f4ca7ce"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.37.0/agentboard-darwin-x64.tar.gz"
      sha256 "7a2336c8c684ce7aa3d6271058833c8e72301294b0d917a50913ebdb2c13d071"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.37.0/agentboard-linux-arm64.tar.gz"
      sha256 "81c12922a7c52d218ad7049747979e45c6341f4af7fa434ffaf678cd1690508f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.37.0/agentboard-linux-x64.tar.gz"
      sha256 "9ed8f7c86aa1de47cc8d9577888a3e95d68381b4b0cc22b78ac74f9931a9747b"
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
