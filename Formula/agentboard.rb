# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.17.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.2/agentboard-darwin-arm64.tar.gz"
      sha256 "1e16a0303847c55f88f78d4d9f999d007d4184aad0c318e63e3b3b53b2c1f700"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.2/agentboard-darwin-x64.tar.gz"
      sha256 "ba0111385c89c49f8af7a4ba33f2cd316c0ff615539d2d0aff5a155aeef0924d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.2/agentboard-linux-arm64.tar.gz"
      sha256 "03d6747d0873e7f25a56596b3d359a48266d416c3b3d41deec0abffb9a54176d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.2/agentboard-linux-x64.tar.gz"
      sha256 "e28465672e7b8742b9381ab96b5ad5e6f813410223b9e27f8fa3e25863a0e7b6"
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
