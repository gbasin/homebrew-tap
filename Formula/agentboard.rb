# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.13"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.13/agentboard-darwin-arm64.tar.gz"
      sha256 "10681ec873fcabee9c5ad54f4a922a38b971a91bb66f1aa74b7d2b1770f1ca89"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.13/agentboard-darwin-x64.tar.gz"
      sha256 "65fbf9fa6faa0f036391fc98900364a02fc35ec589576f22ddd5a129e6c002ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.13/agentboard-linux-arm64.tar.gz"
      sha256 "31131c75f4eb4bfe9a281395a4337ad3109e09bc475f713b346b99b03dd27a79"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.13/agentboard-linux-x64.tar.gz"
      sha256 "7c3a75b1434b0795a8371395e1e03368757ee4e34af04012ff17316ed2099906"
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
