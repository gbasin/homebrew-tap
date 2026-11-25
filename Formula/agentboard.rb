# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.48.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.2/agentboard-darwin-arm64.tar.gz"
      sha256 "72c72aa0fcbf88ed789f09191768acc45dd4cd156d10fba51ed436960ed78848"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.2/agentboard-darwin-x64.tar.gz"
      sha256 "99414f3c87abde0e8925dd592236392529d8fd6ae55029cf0b8431b591b159a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.2/agentboard-linux-arm64.tar.gz"
      sha256 "6fa157e005bffc0b74c32a88f7edcfe26ba223490279c693fc1a9bc8e7c9d0ea"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.2/agentboard-linux-x64.tar.gz"
      sha256 "b1d50cd48b9a3198eecf6ddee5713bbcd82a9f3695e533c1e1b3702c869b717c"
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
