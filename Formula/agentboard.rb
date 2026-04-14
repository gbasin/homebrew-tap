# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.42"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.42/agentboard-darwin-arm64.tar.gz"
      sha256 "3173f20444fc9ca3aabf036e3050b660f74c7e415c4f52bf9cb024c255a3df38"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.42/agentboard-darwin-x64.tar.gz"
      sha256 "c16bc96adef00705ed9b89f74d87527b50a65dd89ad8cda12b5e6fa2c7a31669"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.42/agentboard-linux-arm64.tar.gz"
      sha256 "cc6b8792da30947973a728455e0a3dbc6613f98d077d9793827b1d3cf5a5ce7c"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.42/agentboard-linux-x64.tar.gz"
      sha256 "a14ee4caeee340caa9c42eebed998c348aa8ff84784226bf13e42ce2b5308ea4"
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
