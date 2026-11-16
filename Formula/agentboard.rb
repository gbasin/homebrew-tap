# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.9/agentboard-darwin-arm64.tar.gz"
      sha256 "ca1fc415821116d520428417703f75d5bd9b66de4cc649e658f7ac70524eae1d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.9/agentboard-darwin-x64.tar.gz"
      sha256 "aa364e6c11c5658348f970d7910f8c08712780e36937d0a0bc6180572273cb94"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.9/agentboard-linux-arm64.tar.gz"
      sha256 "e1dab6b5fc0b678eb17c5097931889bd03c27ef7f9423babbb24116233a50244"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.9/agentboard-linux-x64.tar.gz"
      sha256 "dd7dfb8a6a9c1ba6173e61e1ec79d94b968e32f9db34eb3f55334e16d54a4c5c"
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
