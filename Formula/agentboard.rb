# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.16"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.16/agentboard-darwin-arm64.tar.gz"
      sha256 "ec6914206d38b556ab3cd1a63cc8a7c29eab9cae68b95a296b8e8e5d478a2b9a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.16/agentboard-darwin-x64.tar.gz"
      sha256 "3ec164917c7b2c7d935cd96855cfc20003878e5780001848edc6b1e4bd2495d8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.16/agentboard-linux-arm64.tar.gz"
      sha256 "8337fb33688034e4aae826c76327e58013b18edd1172fb46429fa494f26ec178"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.16/agentboard-linux-x64.tar.gz"
      sha256 "f5e952e49cda98b0cf8acb3f158686ec64f8c860d0af58b6b34584dde42cd1a2"
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
