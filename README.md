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
- `[bootstrap.packages]` in `mise.toml` — Homebrew formulae, **macOS only**.
  Omarchy owns package management on Linux (pacman/AUR) so this table is a
  no-op there.

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
    mise bootstrap dotfiles apply   # symlinks/renders configs into $HOME
    mise bootstrap packages apply   # macOS only: installs Homebrew formulae

`mise bootstrap` (no subcommand) runs packages + dotfiles + everything else
mise knows how to bootstrap in one shot. See `mise bootstrap --help`.

Useful commands
----------------

    mise bootstrap dotfiles status          # what's applied / out of sync
    mise bootstrap dotfiles apply --dry-run # preview changes before writing
    mise bootstrap packages status          # which brew formulae are missing (macOS)

Local, machine-specific overrides that shouldn't be tracked in git go in
`~/.bashrc.local` (sourced automatically, e.g. secrets/tokens) and
`~/.aliases.local`.
