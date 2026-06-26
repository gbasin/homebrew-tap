# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.2/agentboard-darwin-arm64.tar.gz"
      sha256 "a23b256a173dd695ed6fbcbdcb1bddded0baba2c5fbc45105a068465cd5b70e0"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.2/agentboard-darwin-x64.tar.gz"
      sha256 "bc2df502a1cf9e4a571923110e62c1f4fd475ed27340b41258272baad1b65022"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.2/agentboard-linux-arm64.tar.gz"
      sha256 "605bbb6b79685f46583a258670595f3804517af075d8e5bc693e9c42b7c962d0"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.2/agentboard-linux-x64.tar.gz"
      sha256 "f3b8e09cc777c87a1b609cfe26737823e94485c346db721677fb9a2b74b7303f"
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
