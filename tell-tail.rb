class TellTail < Formula
  desc "Bounded-memory log throughput and severity monitor"
  homepage "https://github.com/ding-labs/tell-tail"
  version "0.4.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    on_arm do
      url "https://github.com/ding-labs/tell-tail/releases/download/v0.4.0/tell-tail-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "2442860972633f9fb64beb5e45d74244c5b59f400076604af60cba44809d15dc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ding-labs/tell-tail/releases/download/v0.4.0/tell-tail-0.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4487fc41128501c0640ec29d860aad0c6fff71839a1f5966fd59ae8ae6acb9b9"
    end
    on_arm do
      url "https://github.com/ding-labs/tell-tail/releases/download/v0.4.0/tell-tail-0.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9539104e22ec82c81bdf9f9681f26911504f16689fe7fce0b7033c9a2d48cae5"
    end
  end

  def install
    bin.install "tell-tail"
    pkgshare.install "THIRD_PARTY_NOTICES.md", "THIRD_PARTY_LICENSES", "BUILD.json"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tell-tail --version")
    output = pipe_output("#{bin}/tell-tail --output json", "INFO one\nWARN two\nFATAL three\nunknown\n", 0)
    snapshot = JSON.parse(output)
    assert_equal 4, snapshot.dig("totals", "records")
    assert_equal 1, snapshot.dig("totals", "levels", "warn")
    assert_equal 0.25, snapshot["error_ratio"]
  end
end
