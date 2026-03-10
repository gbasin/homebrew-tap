# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.23"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.23/agentboard-darwin-arm64.tar.gz"
      sha256 "a52d6e86a4df6641d9d6abd9d2a35c81c97eaa5db20f2f58d20ca753a310c49b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.23/agentboard-darwin-x64.tar.gz"
      sha256 "873964bc71249bef35f04d4c99c16c8b53ca9ea520fbd4fb91f4623e41864648"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.23/agentboard-linux-arm64.tar.gz"
      sha256 "c6fcedfd89d98eedc98250b7b91809226f2f51481af690d4e5f267b44c77eda1"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.23/agentboard-linux-x64.tar.gz"
      sha256 "50b6f4822dadd557912c311803839292acbd5326024b365406f15d47d148bb8a"
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
