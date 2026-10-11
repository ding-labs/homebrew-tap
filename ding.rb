# typed: false
# frozen_string_literal: true

# Generated from qualified native archives; publication requires release review.
class Ding < Formula
  desc "Persistent watches and durable alerts for developers and agents"
  homepage "https://ding.ing"
  version "0.15.1"
  license "Apache-2.0"
  depends_on macos: :ventura if OS.mac?

  on_macos do
    on_arm do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.1/ding_darwin_arm64.tar.gz"
      sha256 "d7a113f0acc7072fffb21052fc67f7b3a1f06bc06736fe326f2a1d258a952d80"
    end
    on_intel do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.1/ding_darwin_amd64.tar.gz"
      sha256 "85f67b4a7becde98d6cb7db9b9a0a933e6e08e3d3e75bd6512af64b691342283"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.1/ding_linux_arm64.tar.gz"
      sha256 "369fac1462d88f1332e14c04d9ea6fc486a1d4d92629f953d90436a6e308881b"
    end
    on_intel do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.1/ding_linux_amd64.tar.gz"
      sha256 "ca8267db4f55a474385809aaf96a9a83d02323a6f4ffe77b58e7679ad52fc376"
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
    assert_match "0.15.1", shell_output("#{bin}/ding version")
    assert_path_exists libexec/"DingNotifications.app/Contents/MacOS/DingNotifications" if OS.mac?
    system bin/"ding", "demo"
  end
end
