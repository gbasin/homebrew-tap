# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.39"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.39/agentboard-darwin-arm64.tar.gz"
      sha256 "9abeed851b27a7012877a948d90d60fba65c26ea5c3cdb5d7197120cbaa2d6cc"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.39/agentboard-darwin-x64.tar.gz"
      sha256 "1913bfa5683318c9945886b17ecc4f3cc4992fedf136f8f7ac3d91f2a901c23e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.39/agentboard-linux-arm64.tar.gz"
      sha256 "3fba2ff3fe9e951e9cc3516478d13156d791ab87c2ef1166692af25e7f13cc66"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.39/agentboard-linux-x64.tar.gz"
      sha256 "56d23473b0975f44f3647cdaa4eb384933b60fa68e2c56f729612a339385ad92"
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
