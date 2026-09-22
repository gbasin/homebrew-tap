# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.12.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.12.1/agentboard-darwin-arm64.tar.gz"
      sha256 "fda7519ca3676f329b2fc0d79813307cd8f0d19e6da0b243014a00fed31a1abe"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.12.1/agentboard-darwin-x64.tar.gz"
      sha256 "135044b726e511dc2bea802c0aa69697384aef1fdec57ac1ae13dc7fa63341de"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.12.1/agentboard-linux-arm64.tar.gz"
      sha256 "fa9cc58fb26a6dec0f7b9e91e3e4f922d764eff2fa68c397a97050abb5b93bf4"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.12.1/agentboard-linux-x64.tar.gz"
      sha256 "e87798bfe1cedac363b66fd666527909bcd9f899a4e0f9f821004a0d10bcadcd"
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
