# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.48.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.2/agentboard-darwin-arm64.tar.gz"
      sha256 "52474ec5eb152d4104781f564e94c55e8c86497d0059ae1cd9e2a706a1e7561c"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.2/agentboard-darwin-x64.tar.gz"
      sha256 "b32e98f6986cf90c8a2587fb034ac607878294ef9328db1d5b7b7e5585384e54"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.2/agentboard-linux-arm64.tar.gz"
      sha256 "53a9ec9a8de59f67fafcafee1da85b480f3f41117a6656c7f332ffbf92a434fd"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.48.2/agentboard-linux-x64.tar.gz"
      sha256 "f52e80a54429138f3987a998d13d50dd1f3cf02091a0c3ad94f65ae1d8b9b23d"
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
