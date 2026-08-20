# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.20"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.20/agentboard-darwin-arm64.tar.gz"
      sha256 "c9da9ddd2834431acf615ae4aeec665f19e55e306f80ab032cbf8a9fd3f23d60"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.20/agentboard-darwin-x64.tar.gz"
      sha256 "40a1ea169e4c7b513f9839e9b8aa3c93b212bf5776d38e3bc9f90fbee0185328"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.20/agentboard-linux-arm64.tar.gz"
      sha256 "6cbf584b25eb63b5e02427b19dbdf5ba04e2765cfb20bd738a7023c15cce2a18"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.20/agentboard-linux-x64.tar.gz"
      sha256 "ee29424545feed7eec748cc9b8702fcb4eae5906917e998fee4bde9b8d728821"
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
