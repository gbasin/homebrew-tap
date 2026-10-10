# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.26.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.3/agentboard-darwin-arm64.tar.gz"
      sha256 "2ad2e56d453b610dfc27f6a75f56ddc7a6d07172ebae6f0ea3a056cfff6553f4"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.3/agentboard-darwin-x64.tar.gz"
      sha256 "9d26f64e8239e25f7d25e6209db6e12f0d7d29cd26a56ab4d56fe6a9de2b70be"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.3/agentboard-linux-arm64.tar.gz"
      sha256 "7136145006c403753b59c6496a2e3e91eae508600bda83734d7c2dca381aced4"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.3/agentboard-linux-x64.tar.gz"
      sha256 "9ed22c3d4764b1d1be5eccc0f48cbc058ef34f38aaf3f7009407ff6da42bf37b"
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
