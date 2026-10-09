# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.26.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.2/agentboard-darwin-arm64.tar.gz"
      sha256 "7c8722e14f0f80fd588306458d36fe67d4e38abfc1b0c35937735c7d3e6577c6"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.2/agentboard-darwin-x64.tar.gz"
      sha256 "9a7305527a6b9efbb26d78533f7697f9a0ce040109a9f317be3b67e05f5d221d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.2/agentboard-linux-arm64.tar.gz"
      sha256 "0f46c5efe857fe9ca7ec131fc3f0f3dce452201e5e37ef08a43e096017f1172c"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.26.2/agentboard-linux-x64.tar.gz"
      sha256 "45ae986f310699fd691b6f009c15f800796c67f7dcaad4854b824c54e7420691"
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
