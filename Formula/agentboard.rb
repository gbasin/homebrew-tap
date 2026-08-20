# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.14"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.14/agentboard-darwin-arm64.tar.gz"
      sha256 "28a842462a6700f06a51d5344a3c1571114637e37ffab58ce86827399c34f117"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.14/agentboard-darwin-x64.tar.gz"
      sha256 "2b72a9bb3b74b2f11ce7d0db2a2762fdaabbfb1b7cd910689bcb768376cf93f9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.14/agentboard-linux-arm64.tar.gz"
      sha256 "ecfb715d16b80db090cc909a435953e0b166aa0363ab618fc6959df6f32ea11b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.14/agentboard-linux-x64.tar.gz"
      sha256 "52cbd412b62204aadb702b14dd675b819e2b9434c4db1f298f8412819b6930cc"
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
