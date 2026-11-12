class TellTail < Formula
  desc "Bounded-memory log throughput and severity monitor"
  homepage "https://github.com/ding-labs/tell-tail"
  version "0.3.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    on_arm do
      url "https://github.com/ding-labs/tell-tail/releases/download/v0.3.0/tell-tail-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "db144ca5bc2c337cecc660397e3bfc8973c92251a4b83746b52025a33f018c4c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ding-labs/tell-tail/releases/download/v0.3.0/tell-tail-0.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8c853f79174cc2681085933f7466522d2097d4f6c77646457dd921d545dfae30"
    end
    on_arm do
      url "https://github.com/ding-labs/tell-tail/releases/download/v0.3.0/tell-tail-0.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b54ca204af51303c3206a335db0be04bbbbeedbac728e9b88f978fba40130ee9"
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
