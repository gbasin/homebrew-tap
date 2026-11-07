# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.42.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.42.0/agentboard-darwin-arm64.tar.gz"
      sha256 "9359be491e17ea98f462a19e952627d8933b12d864d89a30a61436bf26480031"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.42.0/agentboard-darwin-x64.tar.gz"
      sha256 "a35784652101577b28d97db4a8c074c86054e418e79ff5f334b81f17b20f05cb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.42.0/agentboard-linux-arm64.tar.gz"
      sha256 "207e71eb98b51ea54543d5d9af58507517f3d1d5503ae754c768a9ede2f82e7a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.42.0/agentboard-linux-x64.tar.gz"
      sha256 "d2681b4753d7645fa9e4bc363fa0cc1e22c8cc0177030d484597435ee0aeeac2"
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
