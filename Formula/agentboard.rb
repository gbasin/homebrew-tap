# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.15"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.15/agentboard-darwin-arm64.tar.gz"
      sha256 "855981f540650edb290184b628336ce9886d3dd9b8e484814bb77babb856ba36"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.15/agentboard-darwin-x64.tar.gz"
      sha256 "96df5175dfcf737a26d17a399d6ec613dae504c51e77c7518be2e29a9ccd0a56"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.15/agentboard-linux-arm64.tar.gz"
      sha256 "3950c0337a149b3691874a959fe4383015cccfdbcca58dfc29ba320ddf5f0077"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.15/agentboard-linux-x64.tar.gz"
      sha256 "6f4879257281e80634af33126abab0f5a0fc4d4427ccc2c3adf42f745c6b9b6d"
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
