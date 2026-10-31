# typed: false
# frozen_string_literal: true

# Generated from qualified native archives; publication requires release review.
class Ding < Formula
  desc "Persistent watches and durable alerts for developers and agents"
  homepage "https://ding.ing"
  version "0.15.3"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/ding-labs/ding/releases/download/v0.15.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "616b10fdfa0078af07bb5ae807a2cee5a80814e85e277a18b8de6bf4ba969069"
    sha256 cellar: :any_skip_relocation, sequoia: "80fd04eea4c2e0cb671508e9e0f2bc2450d471c0c607e883c3c44c223ae1b70d"
  end

  depends_on macos: :ventura if OS.mac?

  on_macos do
    on_arm do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.3/ding_darwin_arm64.tar.gz"
      sha256 "a0e716f963d278d64be73a20090162eed619b630f796adf29524d186e6c65d55"
    end
    on_intel do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.3/ding_darwin_amd64.tar.gz"
      sha256 "716a98200d242f9d59c1aa364f535d06e753be183a1f615be0c43f1b0cfdc68f"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.3/ding_linux_arm64.tar.gz"
      sha256 "ec04955656414f6235bc13e2996c3f599e7d90c100a156c49d25b8e7d38c1e70"
    end
    on_intel do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.3/ding_linux_amd64.tar.gz"
      sha256 "ac7013404328e37b4d404c740c2ac5e68f2c63e0ed83c0e60bd6821a438f3b28"
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

      To keep public HTTP watches running while this computer is off, use Ding Cloud:
        https://cloud.ding.ing/auth/login
    EOS
  end

  test do
    assert_match "0.15.3", shell_output("#{bin}/ding version")
    if OS.mac?
      assert_path_exists libexec/"DingNotifications.app/Contents/MacOS/DingNotifications"
      assert_path_exists libexec/"DingNotifications.app/Contents/Resources/Ding.icns"
    end
    system bin/"ding", "demo"
  end
end
