# Ding Labs Homebrew tap

This tap holds the Homebrew packages maintained by Ding Labs.

## Ding

Persistent watches and durable alerts for developers and agents.

```sh
brew install ding-labs/tap/ding
ding setup
```

Accept background startup and create your first watch in the local Console. No
Ding account, Go, Node, Python, or model credentials are needed. The package
includes the Console, local MCP adapter, shell completions and Mac notification
helper. Supports macOS 13+ and Linux on ARM64 and x86-64.

Open the Console again with `ding ui`; inspect monitoring with `ding status`.
Your computer must stay awake and connected. Ding manages its own user service,
so there is no separate `brew services` command.

### Upgrade

```sh
ding service stop
brew update
brew upgrade ding-labs/tap/ding
ding setup
```

Homebrew owns package updates. Before removing Ding, run `ding service uninstall`,
then `brew uninstall ding-labs/tap/ding`. Watch data is retained.

[Setup guide](https://docs.ding.ing/operate/local-setup/) ·
[Source and releases](https://github.com/ding-labs/ding)

## Tell-Tail (release pending)

[Tell-Tail](https://github.com/zuchka/tell-tail) measures log throughput and
warning/error ratios with bounded memory. Its release packaging is prepared for
macOS 14+ on Apple Silicon and static Linux binaries on x86-64 and ARM64.
Linux release checks exercise the archives on native runners and in Debian 11
and Alpine userspaces; the binaries do not depend on the host's glibc.

Tell-Tail is not installable from this tap yet. Its first release is held until
the remaining 0.2 validation gates pass. After a validated stable release is
published and imported, installation will be:

```sh
brew install ding-labs/tap/tell-tail
```

Maintainers import an already published release with:

```sh
gh workflow run tell-tail.yml --repo ding-labs/homebrew-tap -f tag=v0.2.0
```

The workflow rejects drafts and prereleases, verifies the release manifest and
archive checksums, generates the formula, then installs and tests it on macOS
and both Linux architectures before committing `tell-tail.rb`. It uses the
selected release's own packaging tools so future changes on `main` do not
invalidate older releases. No cross-repository write token is
needed. It never creates a Tell-Tail release or changes `ding.rb`.
