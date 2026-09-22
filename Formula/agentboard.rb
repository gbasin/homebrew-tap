# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.9.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.9.2/agentboard-darwin-arm64.tar.gz"
      sha256 "d3b274fd8a67bf61ba40a8d1ca10dafdbb5c84ef4630d4c92d7f02613de96544"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.9.2/agentboard-darwin-x64.tar.gz"
      sha256 "6717f0fccd5f0dda3481acfe7731ba19945274521914dd0aa85150e33c783fd2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.9.2/agentboard-linux-arm64.tar.gz"
      sha256 "9288a2d55274f720bb6f4c45ce190f13cd0c0bc623bfe3487696190b803a175b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.9.2/agentboard-linux-x64.tar.gz"
      sha256 "8069a62cecbf92c3df219f5cd64b296f6bf562261b05d7339f72663267e6c746"
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
