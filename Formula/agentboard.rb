# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.15"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.15/agentboard-darwin-arm64.tar.gz"
      sha256 "773999aab0ab30dc9d5849b2ce25a1420ef000fef76a88ef71abbe74accd8b64"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.15/agentboard-darwin-x64.tar.gz"
      sha256 "c1b8ddc45890dc44862a8403719ba4b65c6e70dcee3e9b12d217b408497bc070"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.15/agentboard-linux-arm64.tar.gz"
      sha256 "d5d8816b6cf7bfb70cc832ba90949b904bce8472314f588fe5c80a6d86905b79"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.15/agentboard-linux-x64.tar.gz"
      sha256 "6fa004534612f1858cbb206ca9fece0a1fdd5ad01181ed4dad84d91c11ef9ead"
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
