# typed: false
# frozen_string_literal: true

# Generated from qualified native archives; publication requires release review.
class Ding < Formula
  desc "Persistent watches and durable alerts for developers and agents"
  homepage "https://ding.ing"
  version "0.15.0"
  license "Apache-2.0"
  depends_on macos: :ventura if OS.mac?

  on_macos do
    on_arm do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.0/ding_darwin_arm64.tar.gz"
      sha256 "ec0d4a18e8b325fd8197665af039b7e9f22fa77fe84d7fc38b2f721c1059d527"
    end
    on_intel do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.0/ding_darwin_amd64.tar.gz"
      sha256 "dd6f40a264077934605417e5e579924017373101356d73bc2b5f01fdeee8c841"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.0/ding_linux_arm64.tar.gz"
      sha256 "ece2c289cc430976c7283bcc3e82a8662924a9e982cbacee8a3503dcc14781ac"
    end
    on_intel do
      url "https://github.com/ding-labs/ding/releases/download/v0.15.0/ding_linux_amd64.tar.gz"
      sha256 "092d661ed63eb29bc19bdd652aef432a86585f09cc2f31897ae48febd81966bb"
    end
  end

  conflicts_with "ding-preview", because: "both provide the ding executable"

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
    assert_match "0.15.0", shell_output("#{bin}/ding version")
    assert_path_exists libexec/"DingNotifications.app/Contents/MacOS/DingNotifications" if OS.mac?
    system bin/"ding", "demo"
  end
end
