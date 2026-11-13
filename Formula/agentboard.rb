# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.7/agentboard-darwin-arm64.tar.gz"
      sha256 "b213e3ba9f4979fdf9dc9059f92ea88e152c7e52e3c1df354be7f8f2e7e61327"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.7/agentboard-darwin-x64.tar.gz"
      sha256 "c66c40817b02a3c5aae472e892d5804804ce7b4d074b90b1910c9f1d233614eb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.7/agentboard-linux-arm64.tar.gz"
      sha256 "426f0726189549d4420f16285285437bdb6149ada86bcc9fd07ee91765510bae"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.7/agentboard-linux-x64.tar.gz"
      sha256 "61577e15dcee2372f3fbed7099d9c95addd360eeeceb36a2fdb6fa3787487a7e"
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
