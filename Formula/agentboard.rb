# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.17.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.1/agentboard-darwin-arm64.tar.gz"
      sha256 "398c59f519725c1fd69f4d692d3a6b6394f60d9c6953a1e10a673f41d0835081"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.1/agentboard-darwin-x64.tar.gz"
      sha256 "33bbdeeee363599baa5b72d11e5e04ed8d3f8a2de3317c66280a7798fbe2d76f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.1/agentboard-linux-arm64.tar.gz"
      sha256 "660fa73261c75cfd6bbf0ad0d49dfb275d5b3d0de71342bf7296a79326b8a8ca"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.1/agentboard-linux-x64.tar.gz"
      sha256 "f137f9a2ca1ef1f49b788b5734be251ba2b931f32e8bf55abe754d36e808d2e2"
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
