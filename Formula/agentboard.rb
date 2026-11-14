# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.8/agentboard-darwin-arm64.tar.gz"
      sha256 "324bbfd5b5e079cef939d5619308bb5905700050b9cfd300150241edf2116d04"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.8/agentboard-darwin-x64.tar.gz"
      sha256 "bb35672d67678a7fea54fc15cbf55b4a8a7f6dc0a2cbeee2cff11ffd30d109a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.8/agentboard-linux-arm64.tar.gz"
      sha256 "bccfc05d5e04fb8fc46952966ab93274d9149e3f890f842b9eb9280fbc97f304"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.8/agentboard-linux-x64.tar.gz"
      sha256 "c14c4c04247a207fe018ab83e6e131db6abdf87b417068ca950cf5c6f74fa3e4"
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
