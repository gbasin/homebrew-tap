# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.0/agentboard-darwin-arm64.tar.gz"
      sha256 "85969a914ccc473d1804e0a8acedc02e007ef21aca8e600caad96115bab1e1a0"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.0/agentboard-darwin-x64.tar.gz"
      sha256 "98440697d1815e0d367ad7b0ff4ce77b71c89a9cda36991803e924fd46f91a33"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.0/agentboard-linux-arm64.tar.gz"
      sha256 "f05b56affa15083fc6a210507f04a847d8c6d5127658afc317e408d53261e537"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.0/agentboard-linux-x64.tar.gz"
      sha256 "e6c84a6f73b0317f8145aed4497450f18a5bb0d39b96845f62d7ddbcf2be072a"
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
