# typed: false
# frozen_string_literal: true

# Generated from qualified native archives; publication requires release review.
class Ding < Formula
  desc "Persistent watches and durable alerts for developers and agents"
  homepage "https://ding.ing"
  version "0.15.2"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/ding-labs/ding/releases/download/v0.15.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4cdd0c414760cccabc5c159c23753117f75254a8af59b5e2a84f2b468a54d3cf"
    sha256 cellar: :any_skip_relocation, sequoia: "78a7479e751cabe7bcbe7f2f2516736b1807b07c81f21828d69044addcc67bf5"
  end
  depends_on macos: :ventura if OS.mac?

  on_macos do
    on_arm do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.2/ding_darwin_arm64.tar.gz"
      sha256 "1a048f5c1bb4508c26a680b90f483d37f83aeebebd1a616f1353cddd0ac6cef3"
    end
    on_intel do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.2/ding_darwin_amd64.tar.gz"
      sha256 "a6b24085a396d1660f66093bf4c049c1e56ad6514600caf19da2ff578aa4a227"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.2/ding_linux_arm64.tar.gz"
      sha256 "e15f7248588b0b9fc54262b80f7e6fc0f4cda4f09d547d65d9c6d0f7604e118d"
    end
    on_intel do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.2/ding_linux_amd64.tar.gz"
      sha256 "7540cdde898208accb3e3bbd222449ec00c41b21b22b2a6f23937d052ecb6eb8"
    end
  end

  def install
    libexec.install "ding"
    libexec.install "DingNotifications.app" if OS.mac?
    bin.install_symlink libexec/"ding"
    generate_completions_from_executable(bin/"ding", "completion", shells: [:bash, :zsh, :fish])
  end

  def caveats
    <<~EOS
      Run ding setup to choose background startup and create a watch without an account.
      Ding manages its own user service; do not register a second brew service.
      Before upgrading, run ding service stop. After upgrading, run ding setup.
      Homebrew owns these binaries; use brew upgrade instead of ding update install.
    EOS
  end

  test do
    assert_match "0.15.2", shell_output("#{bin}/ding version")
    if OS.mac?
      assert_path_exists libexec/"DingNotifications.app/Contents/MacOS/DingNotifications"
      assert_path_exists libexec/"DingNotifications.app/Contents/Resources/Ding.icns"
    end
    system bin/"ding", "demo"
  end
end
