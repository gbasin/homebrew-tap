# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.7.0/agentboard-darwin-arm64.tar.gz"
      sha256 "5e9c20737e0eca8971670f3218293da97b4212d4a3a1a7814e6c3b036d55c3a5"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.7.0/agentboard-darwin-x64.tar.gz"
      sha256 "0e25ccf7c78650c2f1e41ffc3744665326014cd8c2276b3c296229def0ed3993"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.7.0/agentboard-linux-arm64.tar.gz"
      sha256 "e4d828abc772cd1548cbd09c0b38d5e55ab5285c329444b90b78348978a85889"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.7.0/agentboard-linux-x64.tar.gz"
      sha256 "eec198cea18763dc40be97373d5e20f61069b3c7519ac94a53de32f2102500bb"
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
