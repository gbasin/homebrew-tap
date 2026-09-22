# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.10.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.2/agentboard-darwin-arm64.tar.gz"
      sha256 "2abff0592784f0383a1b99f58554b40c5eefae5325e7c40652d4ad2ce195afb2"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.2/agentboard-darwin-x64.tar.gz"
      sha256 "97285ba5eb6dfe107fb25a33da8f6d38aca722901d16fcc64761c6895d378553"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.2/agentboard-linux-arm64.tar.gz"
      sha256 "48bb818bb5aed2db944245c9fad4462eb49d6b88f74c177c88617ad283229354"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.2/agentboard-linux-x64.tar.gz"
      sha256 "92daaa0f52e0f6b3ed5762733bc5e5aa2e96415a1522c8fa25ba828313520867"
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
