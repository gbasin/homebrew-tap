# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.24.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.24.0/agentboard-darwin-arm64.tar.gz"
      sha256 "45c34db71902faf1457001beb057734cbf491c4acdf25d108bcd540be29165ec"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.24.0/agentboard-darwin-x64.tar.gz"
      sha256 "5dce416142f55740902fa0af4a1fe8c760da5eabd52047ad8816286313b74c66"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.24.0/agentboard-linux-arm64.tar.gz"
      sha256 "da47691cbd64abf426fe65340df71ece985b6af1891207b6e9011b9e947d7a31"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.24.0/agentboard-linux-x64.tar.gz"
      sha256 "bac58fc15535a8347f0270abcbf0e555fb639c9341bf577583d5db3c1455a97f"
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
