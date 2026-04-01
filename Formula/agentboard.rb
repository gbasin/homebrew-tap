# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.36"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.36/agentboard-darwin-arm64.tar.gz"
      sha256 "d15070908b4a51c50cafaa4e2b4ea755fc7c3bb4fff01a277653f9e64ca642af"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.36/agentboard-darwin-x64.tar.gz"
      sha256 "e1c3e7f219cae905dda4a9312016bc6aa8509607bb876d198f3bd56685d3139a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.36/agentboard-linux-arm64.tar.gz"
      sha256 "8397fe4395ce2f6fe1d5f18862e5b5a285b3faecc5fc62545bf2a1d2e040c6b3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.36/agentboard-linux-x64.tar.gz"
      sha256 "fe5a92c0e51875f52a813a18e5901ccf65b82050eaa71760713dfef570451a6b"
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
