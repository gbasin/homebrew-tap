# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.27"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.27/agentboard-darwin-arm64.tar.gz"
      sha256 "e497539ad42e6be89a9d264cb249ada229f690cc4038c05f64f92c7845a57bf7"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.27/agentboard-darwin-x64.tar.gz"
      sha256 "f261b1f11c9ed88486991bbcab16c2e5af8b2bcb969e64b32a1af4de31edbe60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.27/agentboard-linux-arm64.tar.gz"
      sha256 "4b50efb3ccefaedac64f1e2ab1368207e35f428220fd88b32a5914585ce3e6f9"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.27/agentboard-linux-x64.tar.gz"
      sha256 "fd78de08e6b35c6022af335f3955c1f9e0f6f60372a55994a715560cbb40fe18"
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
