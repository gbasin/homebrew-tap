# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.28"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.28/agentboard-darwin-arm64.tar.gz"
      sha256 "759cb883effe1920a0de3be10e0bf7ef9b748ef5d4f06cd7a93d45e6ea15998b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.28/agentboard-darwin-x64.tar.gz"
      sha256 "31cf87bb38285d9673f9438c58f5cedb07a744242e636fdc594b04ad7eb3dc54"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.28/agentboard-linux-arm64.tar.gz"
      sha256 "624aa7470982c221fba750ccd4cd5d5c3c80391b7f73bfa449a68c56ca67efca"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.28/agentboard-linux-x64.tar.gz"
      sha256 "d9510c37b51e1ed3458c7c404d66578e73b293a9a39696363de4e20e992dd89b"
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
