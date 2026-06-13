# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.53"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.53/agentboard-darwin-arm64.tar.gz"
      sha256 "7836f85e331025461a29c5b29e16e08fcaa6e63c5c65b50e12ce066ab60b2848"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.53/agentboard-darwin-x64.tar.gz"
      sha256 "65c019e23ea598e47313cf483e624c9b111ee54351ebefc2cc83f2c9d207a0e7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.53/agentboard-linux-arm64.tar.gz"
      sha256 "7b777c4e6f89c1823bbaa6406f7c3457f50959b0a22da5b0b65c1088bc99b9b8"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.53/agentboard-linux-x64.tar.gz"
      sha256 "d8de398caecb114b1171f5ef0509e5fcef8d02eb5f8069dcb90ce56cf7894742"
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
