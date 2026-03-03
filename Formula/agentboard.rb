# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.20"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.20/agentboard-darwin-arm64.tar.gz"
      sha256 "8c919e6283620c02bc803c42dacee3482ef1d16707c040ff724ab8b8172c41e1"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.20/agentboard-darwin-x64.tar.gz"
      sha256 "0b211d46e86e6f1e340df67901ef331d5d5918f8425eab802c5624b0713474f0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.20/agentboard-linux-arm64.tar.gz"
      sha256 "af26c12f729fcde98cb5d51b68f12eef92afb696855c49b56254dce8f4041660"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.20/agentboard-linux-x64.tar.gz"
      sha256 "f3c1f65cee76f313719b7fcd38b77a94a9b08547c99919d69f06267a21b820cf"
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
