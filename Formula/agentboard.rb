# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.39.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.39.0/agentboard-darwin-arm64.tar.gz"
      sha256 "5236e0eb6e8fac6f76bffb551c6a31d36c99ab726fcd5337428941479f869504"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.39.0/agentboard-darwin-x64.tar.gz"
      sha256 "8a5e3713017b02b222b12ebe7043c18ebe95aa0663a128fc0aa6ce6b7aea9819"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.39.0/agentboard-linux-arm64.tar.gz"
      sha256 "8201c10013dcfbb44eb3de4c15f1b83729fbea701fb7790afe09c85e4457df4a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.39.0/agentboard-linux-x64.tar.gz"
      sha256 "199193602f3d1941218efe7066e183ae8c267abb36c61da414e8ae9079892750"
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
