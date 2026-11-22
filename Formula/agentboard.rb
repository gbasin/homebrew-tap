# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.11/agentboard-darwin-arm64.tar.gz"
      sha256 "c27a39a0237dfabe6b74d9870bb893161e219dc34e4d3ef039b2f3ca6886d73f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.11/agentboard-darwin-x64.tar.gz"
      sha256 "f5606e075e1f180187952b9fa6e6804f0874ea06cf9a7aa82d05dc64ee117e2d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.11/agentboard-linux-arm64.tar.gz"
      sha256 "d99bfb7f83280a7ddee5d64eb3abad2f937402c4e15af73eaae0b706d36c0147"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.11/agentboard-linux-x64.tar.gz"
      sha256 "294a05da30ce294dab698317756f50afdbc6ed51640e228035101fdd366eeaf6"
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
