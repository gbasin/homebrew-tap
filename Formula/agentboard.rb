# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.2.32"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.32/agentboard-darwin-arm64.tar.gz"
      sha256 "cae8bad1e8fb90e16c1eb7dc4077d9bfce4ee09074018f76a71786ca268ab367"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.32/agentboard-darwin-x64.tar.gz"
      sha256 "55b831e03ac25b0f2f0fd8e33bfaf8db8e7a17ff23889407100405139ff31208"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.32/agentboard-linux-arm64.tar.gz"
      sha256 "a30de26e22f128ff0c90237454821ab089d1445f7692fb92c8b99cb30eed9ff6"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.2.32/agentboard-linux-x64.tar.gz"
      sha256 "103aca7f9c5bd0f38098512c6c6c5ba6c413b2ccaa46fe04573a312b2f5ffdce"
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
