# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.19"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.19/agentboard-darwin-arm64.tar.gz"
      sha256 "2730dde474574f47293446a2efa48919d0c7f176336a50c4cb6bf4417112f5e0"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.19/agentboard-darwin-x64.tar.gz"
      sha256 "caaedddd6347d1fea519bbd6fa6372157785209e1b65aec202642a68f58fc56f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.19/agentboard-linux-arm64.tar.gz"
      sha256 "6d106497d77d0d3cbbe6da3b2628d81c7152e1c5481c8666aa5ebf07a875d832"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.19/agentboard-linux-x64.tar.gz"
      sha256 "08b66f95254f9e353bf08d235f3bdd144a84399dd5731138ef5c7532d63a88f6"
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
