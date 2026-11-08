# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.43.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.2/agentboard-darwin-arm64.tar.gz"
      sha256 "0e185427ebf8b4b193718da1cbe3ece7c7e3a28700221366bb0c809925de2f82"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.2/agentboard-darwin-x64.tar.gz"
      sha256 "7e902bb647ab338dcdb2a0e56de803c27177e8e6bc8931408b28f1cb24a39d0a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.2/agentboard-linux-arm64.tar.gz"
      sha256 "f4c803469813e7f2a55287771bee91982dccbd7ef4aac21d18cc57c965f13abb"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.2/agentboard-linux-x64.tar.gz"
      sha256 "dbfc99a6a2c70811fc5fdf8c18e4e07294b68606ec2c82c16056f68926a6c925"
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
