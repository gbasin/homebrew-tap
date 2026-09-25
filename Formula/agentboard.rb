# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.15.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.15.0/agentboard-darwin-arm64.tar.gz"
      sha256 "c78dee8bc48d59c1a3eff37bed62e7090766b6c541d00e1f91653e437dee0dce"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.15.0/agentboard-darwin-x64.tar.gz"
      sha256 "6ab106a0cb33c8f34113ce35e0e466a74cf8c1051229fef78591fc6a090f0653"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.15.0/agentboard-linux-arm64.tar.gz"
      sha256 "2006d797e24a6a65a1f4cdea4381cf45693ad731dfb8b7b772adce7c98c77437"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.15.0/agentboard-linux-x64.tar.gz"
      sha256 "383b4c88f043fed1f64b66f49fd065ae70b79b97a5a856ad60db261ee267c759"
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
