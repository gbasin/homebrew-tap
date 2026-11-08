# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.43.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.0/agentboard-darwin-arm64.tar.gz"
      sha256 "9d2f24677f34e8375762bb8066397de058adac2f049861d453f9c030ee621afd"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.0/agentboard-darwin-x64.tar.gz"
      sha256 "925e0ece11200106da854096652ab9712e638653bc307688c20688175c26e0d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.0/agentboard-linux-arm64.tar.gz"
      sha256 "f8b76eede6a0903779c7b2fafa092cb66d7d137972372f873556cebe87c5b649"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.0/agentboard-linux-x64.tar.gz"
      sha256 "4d3c4823c9052fa1ffe1280a5722c092f55585a4923c7337202442b85a057e7b"
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
