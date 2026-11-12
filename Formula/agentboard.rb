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
      sha256 "ced59a8947820240a2a6736de00c6999c1517c1d2ee7dfdf9bd89e16b3eaa83f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.3/agentboard-darwin-x64.tar.gz"
      sha256 "b9285db5435c3545aeb5bfaa3187da59419c399776aa6393cb3276b11193ec49"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.3/agentboard-linux-arm64.tar.gz"
      sha256 "0ad9608f61f940433d3aa336be53129b1092881649abe78557c7fbcc5247319a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.3/agentboard-linux-x64.tar.gz"
      sha256 "30eb85af548c622c61417ceab87f64615e8acfd1b5cecf3800902d3c5c53de16"
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
