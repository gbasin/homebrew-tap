# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.4/agentboard-darwin-arm64.tar.gz"
      sha256 "13ce6c023001384eabee17ce942cf172750a180119ea12ab726693def761e6f7"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.4/agentboard-darwin-x64.tar.gz"
      sha256 "56c5b6dada12b8951b4d0cd9e889081f3e01d5b104d109340abbeba6bd43a4c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.4/agentboard-linux-arm64.tar.gz"
      sha256 "091fd753ce77403cf4e7fb7bf62cb028c65fe797b009b435971f966ab9b6555f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.4/agentboard-linux-x64.tar.gz"
      sha256 "72fbbce6395b4b313c2dc094dd16393e5b35e2d9750f9d35d5423f0c2919702b"
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
