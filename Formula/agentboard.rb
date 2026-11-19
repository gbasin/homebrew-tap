# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.46.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.10/agentboard-darwin-arm64.tar.gz"
      sha256 "67b8c528cf9ec207f7c2e5c4c7a124b20b053ef81db96c84e49f499b9e56edff"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.10/agentboard-darwin-x64.tar.gz"
      sha256 "5134c369ce104e39f602c98905163b472b64fa998cacdb181791ef9e7f09a299"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.10/agentboard-linux-arm64.tar.gz"
      sha256 "57787b79fdea94b93327d3a34af35767d997bac0919b542e8c2ed0ff1c72b334"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.46.10/agentboard-linux-x64.tar.gz"
      sha256 "659dde76b664e408dae3b6d66020138bac5d74dc590b9aea1ab5fb06215a8790"
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
