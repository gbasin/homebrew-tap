# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.43"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.43/agentboard-darwin-arm64.tar.gz"
      sha256 "90befb7d9763c4085775a376e4fb4989d68cf7d48a64de99fbf64f3e6edb2887"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.43/agentboard-darwin-x64.tar.gz"
      sha256 "606cca16050a180bc794268ec55a486204d84679885cddf10709357475c88924"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.43/agentboard-linux-arm64.tar.gz"
      sha256 "b9df56306cfb30bfc3fa4ebe4beeba3ccf7306d3f9925f598aa1b9c7b3417c9d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.43/agentboard-linux-x64.tar.gz"
      sha256 "bf351b2a88cc0fe6dfef614b6db2e3c6390453b399a9d20d4fbe3c52494b115e"
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
