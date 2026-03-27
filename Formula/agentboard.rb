# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.33"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.33/agentboard-darwin-arm64.tar.gz"
      sha256 "c29e5b196e1620af1c77e74c074bc7b31c800cd5173188e4c3e9828702e1c64d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.33/agentboard-darwin-x64.tar.gz"
      sha256 "6d8206cb0235a3e21aba992254f4e20280e19e83e7f427bb8f3b87b0cfc8ca11"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.33/agentboard-linux-arm64.tar.gz"
      sha256 "9140f5ac3f88f0d76f792aacd66e67b35d614e882206f753b90239fbbdd63fff"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.33/agentboard-linux-x64.tar.gz"
      sha256 "3c4f0115c275bbcfb4c9f417958e18e9451b18fd2f37309e8557280ff2a9afe7"
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
