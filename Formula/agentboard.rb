# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.25.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.1/agentboard-darwin-arm64.tar.gz"
      sha256 "9c16e54037b026e440f3f774c22bea219935e10f0c47a18433969660b05933cb"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.1/agentboard-darwin-x64.tar.gz"
      sha256 "f3203d580673732646ba282c6bb65cd8b68bd67950288cef8a13bec32be691bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.1/agentboard-linux-arm64.tar.gz"
      sha256 "810870cbf4c14a4c9d19cde4aabfb2a8491af2e6039743775b1e45db8795fa2a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.1/agentboard-linux-x64.tar.gz"
      sha256 "130ada4deb7f5000ce52272fb81761e8b4234a24bde2c04f98885754ad620bba"
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
