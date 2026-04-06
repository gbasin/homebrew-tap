# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.40"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.40/agentboard-darwin-arm64.tar.gz"
      sha256 "d223f44da8e95312bfdb29ccfe20b936c050cbfdc053c9c156e9ac10e5449aaa"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.40/agentboard-darwin-x64.tar.gz"
      sha256 "83d387adc97d0e8f587860f28b07104f74c3f92686473aeb403184a176483cb9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.40/agentboard-linux-arm64.tar.gz"
      sha256 "f290d2daa77db9b492d052d8bb009fc7ad47420660c0e5625ce60ec12962d632"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.40/agentboard-linux-x64.tar.gz"
      sha256 "e79b109bf362ad69af2697fedd767937f685ec620d30686164c1dee14160c998"
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
