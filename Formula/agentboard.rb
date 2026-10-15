# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.34.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.4/agentboard-darwin-arm64.tar.gz"
      sha256 "7954468d3c65b23b3ac31ce3c0e692cdf8f4910e291016a15ca394d50a3bc976"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.4/agentboard-darwin-x64.tar.gz"
      sha256 "3dbf703ce03985a379f661236539bde70fb544b66722a1df73c6c8150c99ae38"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.4/agentboard-linux-arm64.tar.gz"
      sha256 "0db8449fec9a13da4462540c8ce315b396d27b3e7e95260050cc39803fe70332"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.34.4/agentboard-linux-x64.tar.gz"
      sha256 "bab1851dcdf0c4c36b8b14bf20bc88dfc23cfb51030a4a51849a592bebeb2181"
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
