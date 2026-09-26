# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.17.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.3/agentboard-darwin-arm64.tar.gz"
      sha256 "ae94d198b944f26d5f0a5a81cbefddd016bc9626ba13e656975dd0a7fca6a16a"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.3/agentboard-darwin-x64.tar.gz"
      sha256 "9f0e2700907a605ceaa140e2ab2516d95880bd1e9c7e3b2cdccd347c699f4a4f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.3/agentboard-linux-arm64.tar.gz"
      sha256 "9c5f4e489e1792e21ebc73aef49511992c6727a5c891532b2a9c81d6c4e4acc8"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.17.3/agentboard-linux-x64.tar.gz"
      sha256 "ea35cbfba4bc15c492107cab4907546068bdbc4d8c48c0ed7dff2e3662a7e7d7"
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
