# Ding for Homebrew

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

## Upgrade

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
