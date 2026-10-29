class TellTail < Formula
  desc "Bounded-memory log throughput and severity monitor"
  homepage "https://github.com/ding-labs/tell-tail"
  version "0.2.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    on_arm do
      url "https://github.com/ding-labs/tell-tail/releases/download/v0.2.0/tell-tail-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "4b337ab47528246bd87501c7a8465e7c05e67cdfc0b730ba3bf5e8129913e252"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ding-labs/tell-tail/releases/download/v0.2.0/tell-tail-0.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bba2b92598530746d48689fe2b702a8400adda6a123a686e8b24d1186df48729"
    end
    on_arm do
      url "https://github.com/ding-labs/tell-tail/releases/download/v0.2.0/tell-tail-0.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "446278e8351600d0137d6d9cf3cda717ec51e2c5a1931d388929c329c8a7ebb7"
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
