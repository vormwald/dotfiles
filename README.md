Mike's Dotfiles
===============

Managed with [mise dotfiles](https://mise.jdx.dev/dotfiles.html). This replaced
thoughtbot's [rcm](https://github.com/thoughtbot/rcm), which used to symlink
everything in this repo into `$HOME`.

Bash is the shared shell across [Omarchy](https://omarchy.org) (Linux) and macOS —
`bash/bashrc.tmpl` branches on `os()` so one file works on both, rather than
maintaining a separate zsh/prezto setup per machine.

What's managed
---------------

- `config/nvim` -> `~/.config/nvim`
- `config/herdr/config.toml` -> `~/.config/herdr/config.toml`
- `bash/bashrc.tmpl` -> `~/.bashrc` (templated per-OS)
- `bash/aliases` -> `~/.aliases`
- `[bootstrap.packages]` in `mise.macos.toml` — Homebrew formulae. This file
  only loads on macOS (mise's [platform-specific config
  files](https://mise.jdx.dev/configuration/environments.html#platform-environments)),
  so it's invisible on Omarchy, which owns package management there itself
  (pacman/AUR).

Not yet migrated (still just sitting in the repo, unmanaged): `vimrc`,
`tmux.conf`/`tmux.mac.conf`, `gitconfig`, `gitmessage`, `git_template`,
`gemrc`, `config/alacritty`, `config/ghostty`, `config/zellij`. Omarchy's own
Hyprland/Waybar/Walker config is intentionally left alone — it's managed by
Omarchy itself, not this repo.

Install
-------

Install [mise](https://mise.jdx.dev) first (Mac: `brew install mise`; Omarchy:
already installed).

    git clone https://github.com/vormwald/dotfiles.git ~/code/dotfiles
    cd ~/code/dotfiles
    mise trust
    mise bootstrap dotfiles apply             # symlinks/renders configs into $HOME
    mise bootstrap packages apply -E macos    # macOS only: installs Homebrew formulae

`mise bootstrap` (no subcommand) runs packages + dotfiles + everything else
mise knows how to bootstrap in one shot. See `mise bootstrap --help`.

`-E macos` is only needed until `MISE_AUTO_ENV` is set (see below) or mise
2027.6.0 ships, at which point `mise.macos.toml` loads automatically on
macOS without the flag. `bash/bashrc.tmpl` exports `MISE_AUTO_ENV=true` on
macOS, so after the first `-E macos` bootstrap and a fresh shell, plain
`mise bootstrap` picks up `mise.macos.toml` on its own.

Useful commands
----------------

    mise bootstrap dotfiles status                    # what's applied / out of sync
    mise bootstrap dotfiles apply --dry-run            # preview changes before writing
    mise bootstrap packages status -E macos            # which brew formulae are missing (macOS)

Local, machine-specific overrides that shouldn't be tracked in git go in
`~/.bashrc.local` (sourced automatically, e.g. secrets/tokens) and
`~/.aliases.local`.
