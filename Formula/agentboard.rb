# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.41.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.41.0/agentboard-darwin-arm64.tar.gz"
      sha256 "644fadb65f29d5054f1d8dbb1a7fa22d2769aeab79880b5ac48b8ee210097893"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.41.0/agentboard-darwin-x64.tar.gz"
      sha256 "750c57f0eca87817aeeefae98b8eb7ff70c9a772eb891f91e5eebf95639f45cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.41.0/agentboard-linux-arm64.tar.gz"
      sha256 "5488f4ec359f17954f8ffb6e9c366dcd58622b523e63e7903a87f863cff5dde7"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.41.0/agentboard-linux-x64.tar.gz"
      sha256 "93e91814fea7c9549ebaade92816c3672b615067d861d021ce902da06d146b58"
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
