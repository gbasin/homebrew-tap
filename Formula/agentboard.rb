# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.23.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.3/agentboard-darwin-arm64.tar.gz"
      sha256 "3842bd5289c2c9af42666d996ab5dee22223930335fe87ede44ecbe8b8ac573f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.3/agentboard-darwin-x64.tar.gz"
      sha256 "0661867acc38b47f24a88e8ca695700a1acabdf0e3dd62823ad223dd0def64ee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.3/agentboard-linux-arm64.tar.gz"
      sha256 "1d88988b5300af1880ff6f7ecf63aa3f79bbee79c2274abbd3d4560be7affe5e"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.23.3/agentboard-linux-x64.tar.gz"
      sha256 "70bd19aeaaa6cbcafa7a2b52aebf2a82a81ce1866274c300511082616eb0a4c4"
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
