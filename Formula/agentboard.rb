# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.5.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.3/agentboard-darwin-arm64.tar.gz"
      sha256 "464710509ae8ec4e60b6392bc673b5472a5492593d00d9e138289dad2d8d8896"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.3/agentboard-darwin-x64.tar.gz"
      sha256 "177d75cbf724bcff259d16142b73d3108f127ea2a7a5d1eeca0d851cc9e21ac8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.3/agentboard-linux-arm64.tar.gz"
      sha256 "b7b3493107d792d2f74ed06305a5ff891087e458b29fc78aa4297403fe593fb7"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.5.3/agentboard-linux-x64.tar.gz"
      sha256 "4d7507af26001762ee1c05b5e0416367956654bf91a9e685313851c8385e8b26"
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
