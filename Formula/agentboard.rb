# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.1/agentboard-darwin-arm64.tar.gz"
      sha256 "842ff4350c47afc761444bc2b8b1cd96541e53262084ccf9d143f729a004c03d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.1/agentboard-darwin-x64.tar.gz"
      sha256 "51a4ac4319e02aa1f07ce584601995c2f5b8d8a44ba13c71e49b2114b4c7dd01"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.1/agentboard-linux-arm64.tar.gz"
      sha256 "a35e85b3cb2c7cc4d18d049df987ae804f315a033fe6515e44f1e52fe1c14c8d"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.3.1/agentboard-linux-x64.tar.gz"
      sha256 "1750ebcfdb387a5591bc8c3a696e8a8bdbd900b721bba0cd95e33d22550b19b3"
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
