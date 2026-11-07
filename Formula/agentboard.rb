# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.40.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.40.0/agentboard-darwin-arm64.tar.gz"
      sha256 "da3e22ea0baf3de9e0a9577f4a28de9e567dd762fe21c85dba3d244dac14f401"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.40.0/agentboard-darwin-x64.tar.gz"
      sha256 "91208f12a930da3ecb091bf05c46465a24c252b81ae5e812641ac2a13b8396a8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.40.0/agentboard-linux-arm64.tar.gz"
      sha256 "f16b798a7d57a3b56ae0d586bc588686819ca24a0d09551633e9f5949631df69"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.40.0/agentboard-linux-x64.tar.gz"
      sha256 "4a324a699be72b04c34418a3d1477262cba8bd8d839d6c6630329ee251c2d7e1"
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
