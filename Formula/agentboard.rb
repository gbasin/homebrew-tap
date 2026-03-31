# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.35"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.35/agentboard-darwin-arm64.tar.gz"
      sha256 "da5decad5f563d4282517e3798a7bee961c1cb3676195af49855e3207f7ad419"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.35/agentboard-darwin-x64.tar.gz"
      sha256 "783946d29f91f056fdc7a538e2dbcdf9893486748699db823e3399009be321b4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.35/agentboard-linux-arm64.tar.gz"
      sha256 "40eaa344cf1ccb3b8173c9ec1c56bd97196054b2d1c227c4e18f441cead2cc8a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.35/agentboard-linux-x64.tar.gz"
      sha256 "6f753c8835d5393aaf92a3d90623df02dc69adf2d91b1ab35bfc413a09e8350d"
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
