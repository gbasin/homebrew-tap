# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.11/agentboard-darwin-arm64.tar.gz"
      sha256 "7539603c901c0fd7c42b4e53550ed1c9c5903f49c48743b97102baeef7278b53"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.11/agentboard-darwin-x64.tar.gz"
      sha256 "ce71f4f75c17614ca3352d8a54b26b2b81369efad22efcb8f8b3f2a4111133b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.11/agentboard-linux-arm64.tar.gz"
      sha256 "558c01e9306aa4668b6dfdfd190392ade24d741c59bef6f547a2fe4fcde834fb"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.11/agentboard-linux-x64.tar.gz"
      sha256 "87ea245056aefad86c4968980d76e43ccc30c7e3d90419592efe73f0e6b7f37e"
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
