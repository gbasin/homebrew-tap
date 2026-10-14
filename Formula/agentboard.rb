# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.33.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.33.1/agentboard-darwin-arm64.tar.gz"
      sha256 "9f5f214b89e75d93cafa9dff43713d18555a9a88d5c4c52de332b7432977ea8b"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.33.1/agentboard-darwin-x64.tar.gz"
      sha256 "8eeadf5bbaf101f3218862b169c9cae442c969111c7a937394785d8eba8d5855"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.33.1/agentboard-linux-arm64.tar.gz"
      sha256 "7186f50c706fffc2f98ca6c783a19ffafe25bc1274cb49067d7a95bda13c8487"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.33.1/agentboard-linux-x64.tar.gz"
      sha256 "9c47789cee7f4e50ac5daeb550a4672e8b6a72ce966d8043774ca0ce67dc604b"
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
