# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.36.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.1/agentboard-darwin-arm64.tar.gz"
      sha256 "13f406bb8478ac73782ed00ca02a921c4a4a2f7498be895217eebaa094796f75"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.1/agentboard-darwin-x64.tar.gz"
      sha256 "661f9e4acc37b7cf0aa0a60bb86ca552901613926f0e9277c91eb58cb6304b4f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.1/agentboard-linux-arm64.tar.gz"
      sha256 "0e7b99f9b9285a0e6a0ce95c4ee957b659dd4ac7be6a7b8f43d6e52b98147111"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.36.1/agentboard-linux-x64.tar.gz"
      sha256 "94956c75f5f7f098b3aa2be081fa8e9bdba33588c42528fa3a5c7844358c7858"
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
