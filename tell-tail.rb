class TellTail < Formula
  desc "Bounded-memory log throughput and severity monitor"
  homepage "https://tell-tail.dev/"
  version "0.5.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    on_arm do
      url "https://github.com/zuchka/tell-tail/releases/download/v0.5.0/tell-tail-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "30bf225e7eb36041090e0d165c6b0d402f64a342d18b328879d6758f6ed788f5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zuchka/tell-tail/releases/download/v0.5.0/tell-tail-0.5.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0cef94e74ed31d6929ea0528d36b080d6216b702a1a9ed86ae53fc493ae319bd"
    end
    on_arm do
      url "https://github.com/zuchka/tell-tail/releases/download/v0.5.0/tell-tail-0.5.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "689487a26f78927e42fca578b2890ad3ec4ea8da7aeb27303010b53a987296fe"
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
