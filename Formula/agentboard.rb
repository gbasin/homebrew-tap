# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.35.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.35.0/agentboard-darwin-arm64.tar.gz"
      sha256 "852ac8d73ebd055c7890d5a4ed922162892aab7fc86ab803b4aac104923a39cf"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.35.0/agentboard-darwin-x64.tar.gz"
      sha256 "e0f7e4cb8a27f058cb7f8d346a3425d8e7b78c61b0fd95a4748e866b65553d59"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.35.0/agentboard-linux-arm64.tar.gz"
      sha256 "5bd8f2348379327868204b2daf99566d57114c69e0d5e0d919827cbe59b0987e"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.35.0/agentboard-linux-x64.tar.gz"
      sha256 "296745387e6d9e887c1da2f4f986fb4d608dd7e0446a68b6c0cbe8f1b6e10689"
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
