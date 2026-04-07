# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.41"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.41/agentboard-darwin-arm64.tar.gz"
      sha256 "d73655496b78557cfbb68245e91972b02d83ee59a347cbb4bd358591d88dfaa4"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.41/agentboard-darwin-x64.tar.gz"
      sha256 "0cfc62879163eaccf022ddf269f744a60714d87a527b2e39a044ceed0f075735"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.41/agentboard-linux-arm64.tar.gz"
      sha256 "4416003811c081d45eafd9960a0ac67f7f045326708b398e78d05fe862a0cc1e"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.41/agentboard-linux-x64.tar.gz"
      sha256 "e17b157fd026dc471d3a832e157acecc51b90911a0a75c31f516842761290968"
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
