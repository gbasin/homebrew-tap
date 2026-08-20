# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.10/agentboard-darwin-arm64.tar.gz"
      sha256 "50ef432f0bf7cf9309f04930be5dd62dfc04514ea74b03a30550191940c9f773"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.10/agentboard-darwin-x64.tar.gz"
      sha256 "5212aec65c878b01897700f6ddd307cbf31e57fdea96d784dc2e4422fb84cf3c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.10/agentboard-linux-arm64.tar.gz"
      sha256 "c1bb1fac5e8301dfb1206cabd894c352aa7a702b67cf028159fec8039408c34c"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.10/agentboard-linux-x64.tar.gz"
      sha256 "1877f4b96307ac8df138064d97ab74a65cd819f059721edd3f7fae3020456cc8"
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
