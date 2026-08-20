# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.11/agentboard-darwin-arm64.tar.gz"
      sha256 "72809108fff88d5ca48d0e065e566cdb53c94da4f6a663df3d2ce7181aad0764"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.11/agentboard-darwin-x64.tar.gz"
      sha256 "f309603408c4999f68d328b17a4e3981c16972f9dd08fac9482d89e68d4586c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.11/agentboard-linux-arm64.tar.gz"
      sha256 "f03ec2744f76b67888799deaa362221e970413904298301a536ee9aac5f7a9a3"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.11/agentboard-linux-x64.tar.gz"
      sha256 "68b19f965ef4ac82d306a6a74d3af14cc865ca587704a6ef56530ead70fa9db1"
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
