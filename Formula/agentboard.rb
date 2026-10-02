# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.23.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.2/agentboard-darwin-arm64.tar.gz"
      sha256 "1933276f554a2036482663f051be6ec1f98ac81eab0281f1fbae147e1f3c0225"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.2/agentboard-darwin-x64.tar.gz"
      sha256 "375ccc29bd698d5e6829deed2689494003eac24b4ecaa75dfd02c74553ddef93"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.2/agentboard-linux-arm64.tar.gz"
      sha256 "57999558fc0120534681353e686de33a2b3b77cc8dc00fdb6cca9c1d41d39640"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.2/agentboard-linux-x64.tar.gz"
      sha256 "e42d626e8a5fe916a7bbfd9e8258410bb072065d4dcb4df7a5b239055a0f453b"
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
