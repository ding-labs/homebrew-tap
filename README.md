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

## Tell-Tail

[Tell-Tail](https://github.com/ding-labs/tell-tail) measures log throughput and
warning/error ratios with bounded memory. Prebuilt releases support
macOS 14+ on Apple Silicon and static Linux binaries on x86-64 and ARM64.
Linux release checks exercise the archives on native runners and in Debian 11
and Alpine userspaces; the binaries do not depend on the host's glibc.

Install the published native binary with:

```sh
brew install ding-labs/tap/tell-tail
```

For an existing installation, run `brew upgrade ding-labs/tap/tell-tail`. Check
`tell-tail --version` before following version-specific examples in the
[demo guide](https://github.com/ding-labs/tell-tail/blob/main/docs/DEMO.md).

Maintainers import an already published release with:

```sh
gh workflow run tell-tail.yml --repo ding-labs/homebrew-tap -f tag=v0.3.0
```

The workflow rejects drafts and prereleases, verifies the release manifest and
archive checksums, generates the formula, then installs and tests it on macOS
and both Linux architectures before committing `tell-tail.rb`. It uses the
selected release's own packaging tools so future changes on `main` do not
invalidate older releases. The import needs no cross-repository Contents write
token. It never creates a Tell-Tail release or changes `ding.rb`.
