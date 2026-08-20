# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.9/agentboard-darwin-arm64.tar.gz"
      sha256 "a081ac543fff16c417fa0ea35719a001befabc12cef68936e6210b7facac007f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.9/agentboard-darwin-x64.tar.gz"
      sha256 "bdc31b47de15612cb3b804d76f74446fb6e4b98141f050c327d3714168c69e15"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.9/agentboard-linux-arm64.tar.gz"
      sha256 "712e891dad2f1e0516aa86bb223dfab575d74dcbfd5343b546dd4fceaa23e512"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.9/agentboard-linux-x64.tar.gz"
      sha256 "850981fb69ce58e25043e97dbfb17de3ea9153d1f585267fd2e33ba3a868cfb1"
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
