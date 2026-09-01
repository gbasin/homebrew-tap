# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.4.24"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.24/agentboard-darwin-arm64.tar.gz"
      sha256 "102e40808a460073c8140008f9c10b0adac67692f9e710a2551395e911206755"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.24/agentboard-darwin-x64.tar.gz"
      sha256 "ebc893326225e5510f7db2caec25433f3008eb991ab9bdacb156dd89fac05b63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.24/agentboard-linux-arm64.tar.gz"
      sha256 "8d0adc0ee1fbdb6adfbe87a746e170a616e526d9bae6b1f7a1b6b9121b4be76f"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.4.24/agentboard-linux-x64.tar.gz"
      sha256 "ab2e644f4d8914e7385125c86231827e50bfc3fd3fb3044cc28743f27ed493bb"
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
