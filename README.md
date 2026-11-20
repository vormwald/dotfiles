# Mike's dotfiles

Configuration files managed by [mise](https://mise.jdx.dev/dotfiles.html).

## Set up a machine

On macOS, install [Homebrew](https://brew.sh), then install mise and Git:

```sh
brew install mise git
```

On Linux, install Git, [mise](https://mise.jdx.dev/installing-mise.html)
2026.9.13 or newer, Zsh, and the system packages you need from `Brewfile`.
The Homebrew task runs only on macOS.

Clone the repository, trust its configuration, and preview the links:

```sh
git clone https://github.com/vormwald/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
mise trust
mise dot apply --dry-run
```

Install packages, clone Prezto and minpac, link the dotfiles, and install
the tools declared in `config/mise/config.toml`:

```sh
mise run setup
```

If an existing file conflicts, compare it with the repository version and
move it to a backup before retrying. Avoid `--force` unless you intend to
replace the conflicting files. Existing links to this checkout can stay.

Start a new Zsh session after setup. For the Vim configuration, open Vim
and run `:PackUpdate` to install its plugins.

## Migrate an existing checkout

From this repository, preview and apply the mappings:

```sh
mise trust
mise dot apply --dry-run
mise dot apply
mise dot status
```

The mappings reuse rcm's file links and link files individually inside
configuration directories. Other files in those directories stay in place.
The global mise config is now stored at `config/mise/config.toml`; compare
any existing `~/.config/mise/config.toml` before replacing it with a link.

After verifying the links, you can uninstall rcm:

```sh
brew uninstall rcm
brew untap thoughtbot/formulae
```

Skip the untap command if you use other formulae from that tap.

## Update the configuration

Edit the source files in this repository. Linked files take effect as soon
as their application reloads them. After adding mappings to `mise.toml`, run:

```sh
mise -C ~/.dotfiles dot apply --dry-run
mise -C ~/.dotfiles dot apply
```

Run `mise -C ~/.dotfiles run brew` after changing `Brewfile`.
Run `mise install` after changing tool versions in `config/mise/config.toml`.
Use `mise use -g TOOL@VERSION` to update a global tool through its linked config.

Keep machine-specific shell and Git settings in `~/.zshrc.local` and
`~/.gitconfig.local`. Put machine-specific mise settings in
`~/.config/mise/config.local.toml`.
