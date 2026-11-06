# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.38.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.38.2/agentboard-darwin-arm64.tar.gz"
      sha256 "7b80d8186f6783bfcf6d9a4e3df4e70aed91245bfe68d8edc9632eee63b0ce3a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.38.2/agentboard-darwin-x64.tar.gz"
      sha256 "5b791c6b252a730bbd476c3a505fd59fb083d00844575d6ca817f33a1f991ed3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.38.2/agentboard-linux-arm64.tar.gz"
      sha256 "c513bd5965b9374d35ad4cbb42c906ea318711a25065746726ee55cea930c72c"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.38.2/agentboard-linux-x64.tar.gz"
      sha256 "b45a4b3d9663740f0e3fab997ed3ac676b55a08f53b9420422abebf7e94181fc"
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
