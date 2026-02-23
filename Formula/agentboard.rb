# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.17"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.17/agentboard-darwin-arm64.tar.gz"
      sha256 "8e34ed6f475283f1fa0dff9021e1c38dffd3540a67c03acbf114d81fd44388c5"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.17/agentboard-darwin-x64.tar.gz"
      sha256 "2bbc30f909c65c6abee9097b5768d67bc13888eda1ec9b99379f25a9fd1e68fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.17/agentboard-linux-arm64.tar.gz"
      sha256 "b90c5df8521af922c5e0846afb7a046a77510646547e35592731d73ac936bb4f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.17/agentboard-linux-x64.tar.gz"
      sha256 "aea4113fd2c762b185f2f93cb353ba6664fa3467a7b89430a5ce665ac097af69"
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
