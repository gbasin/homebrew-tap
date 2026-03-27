# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.30"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.30/agentboard-darwin-arm64.tar.gz"
      sha256 "7f03c8d46351513658ed5bd311f4e1e911222f2627828fc95ad9fe8468747d53"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.30/agentboard-darwin-x64.tar.gz"
      sha256 "f5292601489f4f8ce88e1f24c226de739a0245fcf369ce92cde35c2f940f66d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.30/agentboard-linux-arm64.tar.gz"
      sha256 "3097443aea4bc042d0c88728c85cc1858ccaf7a4e26ca7f24ae70d8ddc63d467"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.30/agentboard-linux-x64.tar.gz"
      sha256 "ed08efb969af4e4d7fb1d2aefb930e5cad5daa5119cc7235b7f5ce78633aba66"
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
