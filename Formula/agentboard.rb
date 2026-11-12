# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.2/agentboard-darwin-arm64.tar.gz"
      sha256 "f823eafaef118b765aa640198296013a281ae96700974dd6da05c65f47925f87"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.2/agentboard-darwin-x64.tar.gz"
      sha256 "675f3584a3b85b3e1dcf15eff00195ba232fb6deb61018fd8d53e85d742a3bdc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.2/agentboard-linux-arm64.tar.gz"
      sha256 "a25daad9154b3aa8f95a0c7d02b50f01b6a4b913461f9b4ecf89bac7d6e0ca23"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.2/agentboard-linux-x64.tar.gz"
      sha256 "38061ed9fbfbb006dbe945250bf3db00b309449ae14f014b55f4fca563d9511e"
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
