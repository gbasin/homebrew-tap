# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.48.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.0/agentboard-darwin-arm64.tar.gz"
      sha256 "2a9b871fcd7d1bd86909d39b932d3f7ab48c601c7e7e5ca65d35db18fc6070e5"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.0/agentboard-darwin-x64.tar.gz"
      sha256 "1ae3fb6b23b43155b156f56b114be80f5b7e64957695188b927098c9898288f1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.0/agentboard-linux-arm64.tar.gz"
      sha256 "be069b0a6fd642d9017bbdd5214fd2051ac1fb33fc69ba91a32cf5e70308c1cd"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.0/agentboard-linux-x64.tar.gz"
      sha256 "9335fc999cba820683610ac10239dae3ae087619b002e0d87197a996fb9e0e3e"
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
