# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.13"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.13/agentboard-darwin-arm64.tar.gz"
      sha256 "9f52bd06c79b34545f3355953484dc5c8110eb5fe41562e89751504eafcc83c6"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.13/agentboard-darwin-x64.tar.gz"
      sha256 "e76a3ade066bf357d94651c3514887f67cbd66595d51f6760d3276a10b138e28"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.13/agentboard-linux-arm64.tar.gz"
      sha256 "2be40ec651b4432a189280ebdef5795036735e4cd0797225d05a84b28f076eab"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.13/agentboard-linux-x64.tar.gz"
      sha256 "944934f44b0f871fc144d8a7965ec7ae70e4fea6ec52ca1e5e87311383a13796"
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
