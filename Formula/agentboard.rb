# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.10.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.4/agentboard-darwin-arm64.tar.gz"
      sha256 "ffbfb9d2263a5d94db8f5fc65c3849850c409c6a99bace97f9d8b7a582f17fc0"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.4/agentboard-darwin-x64.tar.gz"
      sha256 "75d2be65f3266117a0a410eb59cc3fc2e985130300a7e1c9af4b408f4e209bdb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.4/agentboard-linux-arm64.tar.gz"
      sha256 "10106f9cffececa0a44897d0ab885e89968452f917911f9ca539e789d58582a1"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.10.4/agentboard-linux-x64.tar.gz"
      sha256 "2e6c43f98708c7a36bfee1cbebc9689a6fbd3c4aa5644f29583aa1e5a9a3fbb7"
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
