# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.22.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.22.1/agentboard-darwin-arm64.tar.gz"
      sha256 "07aa8becd547fd5716f2ca7fe89cb7620c4ba6543447c8742d99db684e4aafba"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.22.1/agentboard-darwin-x64.tar.gz"
      sha256 "c9718f185fdf8493070c66572a5094e5f70a06a1e29f208ae904ac015ce0215a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.22.1/agentboard-linux-arm64.tar.gz"
      sha256 "025608722a3b57bc5be64df154a81271eb526d6723abbb05aadb44c9179502e8"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.22.1/agentboard-linux-x64.tar.gz"
      sha256 "016709dc199ab3af521afc232ed7764f7e027d167a2a990159287ccab2505ab7"
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
