# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.52"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.52/agentboard-darwin-arm64.tar.gz"
      sha256 "07aa69f5c2ca03aa4f20138c10a91136f2c32b2b652f850c082c95e7a5fffb89"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.52/agentboard-darwin-x64.tar.gz"
      sha256 "88662fd6ba893632e2be548edbdb0dfa1bc12ee6bcde974a50745e58ed771004"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.52/agentboard-linux-arm64.tar.gz"
      sha256 "67b83142e97be242567908e6d69786fa78e5b40635194c05b466e081cbc0fbca"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.52/agentboard-linux-x64.tar.gz"
      sha256 "0d4384e294b39a7d52e7780e394e4099476f3ff33107d3d080fead52b948b6eb"
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
