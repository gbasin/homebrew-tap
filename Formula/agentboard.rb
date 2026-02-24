# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.19"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.19/agentboard-darwin-arm64.tar.gz"
      sha256 "3c89f881551267bd19e62d97d1b03e3bbd22b1124b65e15edbafe1372c31d334"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.19/agentboard-darwin-x64.tar.gz"
      sha256 "a1bc6465369f338e84f9d019ae27865c01671645b5ca9c9443c7b1f90f8a2edc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.19/agentboard-linux-arm64.tar.gz"
      sha256 "34102cabfcb569848b1e1f4de2497958091af37e5bd7d9c12f39105a7e612647"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.19/agentboard-linux-x64.tar.gz"
      sha256 "438ef3c29026b73a00dbc33b170fba14f9858a617febcd78728be3bfd1acbca4"
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
