# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.45"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.45/agentboard-darwin-arm64.tar.gz"
      sha256 "4139bf4a620840fcb542f67fbf2025d51c83a5656b03e22ee35eb1de7d7cd660"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.45/agentboard-darwin-x64.tar.gz"
      sha256 "30227b31304a2816972a262cd47d4272b51879e13a58c90fbe11519beec7cdeb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.45/agentboard-linux-arm64.tar.gz"
      sha256 "675287baab8a6a78a258ae0ef767592e891464568c418e3ff9f1dd45ccfecd24"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.45/agentboard-linux-x64.tar.gz"
      sha256 "1937ad510478fc01b992eea023af98cad8e7827a1a3198fee9fc1fe177ae01a8"
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
