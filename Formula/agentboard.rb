# typed: strict
# frozen_string_literal: true

# Formula for agentboard - Web GUI for tmux optimized for AI agent TUIs
class Agentboard < Formula
  desc "Web GUI for tmux optimized for AI agent TUIs"
  homepage "https://github.com/gbasin/agentboard"
  version "0.25.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.3/agentboard-darwin-arm64.tar.gz"
      sha256 "025e5482c8df36127cc0a116f22489e8ea316e9e9cbf016ec19f4858987d678e"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.3/agentboard-darwin-x64.tar.gz"
      sha256 "6218810dc94456bbd4bf36905f708383ccfa403314b6d9949c2274962c58e49a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.3/agentboard-linux-arm64.tar.gz"
      sha256 "fcf362ef256c813c66eb62b65e773338da3456738bbe7f2999cde2b8107fbb18"
    end
    on_intel do
      url "https://github.com/gbasin/agentboard/releases/download/v0.25.3/agentboard-linux-x64.tar.gz"
      sha256 "5970cf3092afb1195270ce4f2bbcaf14cb478f2f419ebce3e9df9f1d8c1625a8"
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
