# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.27.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.27.0/agentboard-darwin-arm64.tar.gz"
      sha256 "154351fd6e58c3ceb348a0ab6a0709f6b2dd5aa3b5a8fe8ce65df45a62919c40"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.27.0/agentboard-darwin-x64.tar.gz"
      sha256 "3f9157490cd21ac7d86b1db91e65edef131014ef06b03b1c00dd3b5c3ddc5f96"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.27.0/agentboard-linux-arm64.tar.gz"
      sha256 "82b4ff2b1c448f0676a8cbba3e175faf60cc5fff41cfb35e281a9e4ea6f32814"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.27.0/agentboard-linux-x64.tar.gz"
      sha256 "c5bf0b3c4de8986673217db2a9113ef57bf268e5243aa8933c1c7840e5f4c930"
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
