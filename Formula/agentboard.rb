# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.6/agentboard-darwin-arm64.tar.gz"
      sha256 "a26abca4e4b033fad617c92805ed6496e183903389a053e4610b2cf8364b2483"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.6/agentboard-darwin-x64.tar.gz"
      sha256 "9175bcb9628d3d369dcd05cc6bff48c30b48bf392f2560a6e70dca7193f633f9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.6/agentboard-linux-arm64.tar.gz"
      sha256 "fb8ccb0a5a4cff90c61ea33ab12a4a32ea2f5815e899420819d100d67021c86b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.6/agentboard-linux-x64.tar.gz"
      sha256 "883f373c35927b821796f2ef12b9a9e3b9c09b93afc55c2000c9827a6ced56b8"
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
