# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.21.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.21.1/agentboard-darwin-arm64.tar.gz"
      sha256 "fb730952e6536b75b8c3a3d73ad7160acd499508197d95fb69b1fd0d5057f34f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.21.1/agentboard-darwin-x64.tar.gz"
      sha256 "f2bcf04a4afe3037ca239354401bed59bbf804707522a991f27c34ade476b361"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.21.1/agentboard-linux-arm64.tar.gz"
      sha256 "1872511c864f002289c183bf2d7f8c3a26a1ab1e05aecfc425c28b9be3e0778f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.21.1/agentboard-linux-x64.tar.gz"
      sha256 "2e1293553e77ca4172d9c9534a5168652b88a926852defec90eb92ffc080db08"
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
