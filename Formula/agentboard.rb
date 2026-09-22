# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.10.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.3/agentboard-darwin-arm64.tar.gz"
      sha256 "91e9951f592f897ac6a5b8feb656031498a5b1ddebb4ad51d6a6837a5b85d618"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.3/agentboard-darwin-x64.tar.gz"
      sha256 "2fdbab3ad6b89f15d30b0204e62b339ae1d15978b9dff7e252d9b875340d800f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.3/agentboard-linux-arm64.tar.gz"
      sha256 "c9287623f24854963c8b43c684cea453c23815141b93b8099f7ada8704a67df5"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.3/agentboard-linux-x64.tar.gz"
      sha256 "238417f436d95d99b85833bec40dbef9c1344a9b320e6af6eaea8ac08605f418"
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
