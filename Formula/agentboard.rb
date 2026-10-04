# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.25.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.0/agentboard-darwin-arm64.tar.gz"
      sha256 "d7b31fba345476740e99f8c294856ba8bc7b67e8075f36bbe0c8da728af6cf63"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.0/agentboard-darwin-x64.tar.gz"
      sha256 "5c3310cc03fd3d7338bfd37955664926330dbc61107ffcfc6451876348983c16"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.0/agentboard-linux-arm64.tar.gz"
      sha256 "f08ab17517ab992bcbfc9ce0d5288105eac113223f56cfdefe83a714303e1ee6"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.0/agentboard-linux-x64.tar.gz"
      sha256 "7967ce51ca02df205d8163828a9522ba56a99a47375f2a11d3376d6f6497341a"
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
