# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.25"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.25/agentboard-darwin-arm64.tar.gz"
      sha256 "f2e6a963a81e7928fd50c53e61e5c3839c11eb913326da9d0eea5fdababff9f7"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.25/agentboard-darwin-x64.tar.gz"
      sha256 "dba107e5aecd393bac9184d3ab3e416e54675244348d0b2b9a4b77dc44a6a520"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.25/agentboard-linux-arm64.tar.gz"
      sha256 "1bf50223204d93a16d3439bb5d75aff3c5d007fc7f5d6b69c70832acd5a4de9b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.25/agentboard-linux-x64.tar.gz"
      sha256 "586282ecac535883b6727762e44b6aec86c4cfeb8b5ba776675afdb42b8745b0"
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
