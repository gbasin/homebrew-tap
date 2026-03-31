# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.34"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.34/agentboard-darwin-arm64.tar.gz"
      sha256 "bee8bb949cf3b765bc98bf4c22287842cc7424d9f4d93e3276f5f6f7f6fd6eb4"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.34/agentboard-darwin-x64.tar.gz"
      sha256 "8ca931e6c8b8d41175bddb5c3deff96a08cb78ec58a8a04f628e6a856ea75efe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.34/agentboard-linux-arm64.tar.gz"
      sha256 "262f0980a06b8ec334cc9ab0f58bb6526731eded855ffd3de0f0d8a3274e4cbf"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.34/agentboard-linux-x64.tar.gz"
      sha256 "32049ae22082d958c1501b79eaba01b3b55b64aba48bb1abefff8ea519f227f4"
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
