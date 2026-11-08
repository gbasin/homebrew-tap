# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.43.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.4/agentboard-darwin-arm64.tar.gz"
      sha256 "1bb2110895036082791cb8004029a265e161b1f740500cc64f0368a47c63e902"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.4/agentboard-darwin-x64.tar.gz"
      sha256 "b91fb15be6cd8ef266d28e3630c087edb767d9459b19c84d19f9f4bcaa792d42"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.4/agentboard-linux-arm64.tar.gz"
      sha256 "bacd035c8c3489006ff3506d11f7178870e280464b264e923cfbc194c8bd9d0a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.43.4/agentboard-linux-x64.tar.gz"
      sha256 "5822d876f17e6deed744f37dd123fce577deffa397f89807b8a1d21db933d1c1"
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
