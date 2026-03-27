# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.29"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.29/agentboard-darwin-arm64.tar.gz"
      sha256 "8e4e87b3f4d0780368945cf6e490aa23a0b013aeffd30b2eb73c32b0077bffd9"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.29/agentboard-darwin-x64.tar.gz"
      sha256 "995a01091a21a0f20e62012e0d8fb52ded4b9e3380be80028f8eb4c3cdd65237"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.29/agentboard-linux-arm64.tar.gz"
      sha256 "01525a0f3945288dbab209cbe1d068fd5cc1e6e99efdb5a7b4d8938caef230e1"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.29/agentboard-linux-x64.tar.gz"
      sha256 "c6b99623bf8031cc018620bce55cc00826bedc367f248971e3cea8242978c16c"
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
