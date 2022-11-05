# My Neovim Setup

My personal but distributable Neovim setup powered by [Enfocado](https://wuelnerdotexe.github.io/enfocado) and [human.vim](https://github.com/wuelnerdotexe/human.vim) written in Lua.

## Requirements

- [Nerd Fonts](https://www.nerdfonts.com/) patched with [codicons.ttf](https://github.com/microsoft/vscode-codicons) - to show nice icons.
- [Neovim](https://neovim.io/) >= v0.9.0 (nightly) - obviously.
- [Node](https://nodejs.org/) and [NPM](https://www.npmjs.com/package/npm) - to install language servers and debug adapters.
- [ripgrep (rg)](https://github.com/BurntSushi/ripgrep) - to search patterns with [Telescope](https://github.com/nvim-telescope/telescope.nvim).
- [fd](https://github.com/sharkdp/fd) - to find files with [Telescope](https://github.com/nvim-telescope/telescope.nvim).

## Installation

To install this configuration, you just need to clone this repository to the Neovim user config runtime directory for your operating system, which you can find [here](https://neovim.io/doc/user/starting.html#config), or by running the `:help config` help command within Neovim.
For a clean install, make sure you have all Neovim runtime folders `~/.local/share/nvim` (Linux/MacOS) and `$LOCALAPPDATA/nvim-data` (Windows) clean.

For example, to install on Linux/MacOS:

```bash
git clone https://github.com/wuelnerdotexe/nvim ~/.config/nvim --depth 1
```

DISCLAIMER: If you have a previous Neovim config, make sure to make a backup before installing this setup in case something goes wrong in the process. This is done by backing up the `~/.config/nvim/` folder and its contents.

### Post installation

#### Linters and Formatters

If all goes well, when you enter Neovim for the first time, the plugins and language servers will be installed automatically, you will only have to respond to the confirmation messages.
And then restart Neovim to complete the installation process of JSON Lint, Markdown Lint and Prettier with the following Vim command:

```vim
MasonInstall jsonlint markdownlint prettierd
```

Note that the installed Prettier package is not the official one, this is the only package configured to work with this setup, because making many comparisons, it is undoubtedly the one that offers a better experience in Neovim, and no, IT WILL NOT CAUSE CONFLICTS with your project settings. Here you can learn more about [prettierd](https://github.com/fsouza/prettierd).
So this setup is not ready to work with the official package, so don't try to install it and expect it to work.

#### Debug adapter

Also, the debug adapter must be installed for the adapter protocol configuration to work. To install them you just have to execute the following Vim command

```vim
MasonInstall firefox-debug-adapter
```

IMPORTANT: This setup only provides settings for debugging front-end projects created with the `javascript`, `javascriptreact`, `typescript` and `typescriptreact` frameworks with the debugger for Firefox.

## Keymaps

The keymaps created by this config are very well thought out to be intuitive, meaningful, and most of all, to stick to the essence of Vim without conflicting with it.
Keymaps are normally assigned two letters, which signify an action, for example: `d` + `p` = [D]diagnostic [P]review. Keep in mind that the functionality will always come first and then the action.
This is the standard created and used by this configuration for unique consistency.

IMPORTANT: The `\` backslash remains as the global `<leader>` leadermap.

### General

| VI Mode |         Keymap         | Action                                     |
| :-----: | :--------------------: | ------------------------------------------ |
| Normal  | `<leader>` + `f` + `t` | Toggle the folders explorer                |
| Normal  | `<leader>` + `f` + `r` | Reveal current file in the folder explorer |
| Normal  | `<leader>` + `f` + `f` | Find files in the current directory        |
| Normal  | `<leader>` + `o` + `f` | Find recently opened files                 |
| Normal  | `<leader>` + `m` + `f` | Find Vim files marks                       |
| Normal  | `<leader>` + `w` + `f` | Find words in the current directory        |
| Normal  | `<leader>` + `h` + `f` | Find Vim help tags                         |
| Normal  | `<leader>` + `s` + `t` | Toggle document symbols                    |
| Normal  | `<leader>` + `t` + `o` | Open the terminal in a new tab             |
| Normal  | `<leader>` + `t` + `t` | Toggle bottom terminal                     |

### Folders explorer

| VI Mode |         Keymap          | Action                       |
| :-----: | :---------------------: | ---------------------------- |
| Normal  |           `>`           | Leave directory              |
| Normal  |           `<`           | Enter directory              |
| Normal  |           `h`           | Collapse node                |
| Normal  |           `l`           | Expand node                  |
| Normal  |           `o`           | Expand/Collapse or open node |
| Normal  | Double left mouse click | Expand/Collapse or open node |
| Normal  |         `ENTER`         | Expand or open node          |
| Normal  |       `BACKSPACE`       | Collapse node                |
| Normal  |      `CTRL` + `t`       | Open in a new tab            |
| Normal  |      `CTRL` + `s`       | Open in a new split          |
| Normal  |      `CTRL` + `v`       | Open to the side             |
| Normal  |           `n`           | New path                     |
| Normal  |        `n` + `f`        | New file                     |
| Normal  |        `n` + `d`        | New directory                |
| Normal  |           `m`           | Move node                    |
| Normal  |           `c`           | Copy node                    |
| Normal  |           `d`           | Delete node                  |
| Normal  |           `q`           | Exit                         |
| Normal  |         `<F5>`          | Refresh the folders explorer |

### Windows

| VI Mode |       Keymap       | Action                                   |
| :-----: | :----------------: | ---------------------------------------- |
| Normal  |    `CTRL` + `h`    | Move to the left window                  |
| Normal  |    `CTRL` + `j`    | Move to the down window                  |
| Normal  |    `CTRL` + `k`    | Move to the up window                    |
| Normal  |    `CTRL` + `l`    | Move to the right window                 |
| Normal  |    `Alt` + `h`     | Resize the window on the left            |
| Normal  |    `Alt` + `j`     | Resize the window on the down            |
| Normal  |    `Alt` + `k`     | Resize the window on the up              |
| Normal  |    `Alt` + `l`     | Resize the window on the right           |
| Normal  | `CTRL` + `w` + `m` | Toggle maximizer window                  |
| Normal  | `CTRL` + `w` + `o` | Close all windows except the current one |
| Normal  | `CTRL` + `w` + `t` | Open the current file in a new tab       |
| Normal  | `CTRL` + `w` + `s` | Split horizontally the current file      |
| Normal  | `CTRL` + `w` + `v` | Split vertically the current file        |

### Buffers

| VI Mode |        Keymap         | Action                                   |
| :-----: | :-------------------: | ---------------------------------------- |
| Normal  |       `g` + `B`       | Go to previous buffer                    |
| Insert  |  `SHIFT` + `PAGE UP`  | Go to previous buffer                    |
| Normal  |       `g` + `b`       | Go to next buffer                        |
| Insert  | `SHIFT` + `PAGE DOWN` | Go to next buffer                        |
| Normal  |   `SHIFT` + `Home`    | Move buffer left                         |
| Normal  |    `SHIFT` + `End`    | Move buffer right                        |
| Normal  |       `1` + `b`       | Close all buffers except the current one |

### Tabs

| VI Mode |        Keymap        | Action                                |
| :-----: | :------------------: | ------------------------------------- |
| Normal  |      `g` + `T`       | Go to the previous tab                |
| Insert  |  `CTRL` + `PAGE UP`  | Go to the previous tab                |
| Normal  |      `g` + `t`       | Go to the next tab                    |
| Insert  | `CTRL` + `PAGE DOWN` | Go to the next tab                    |
| Normal  |      `1` + `t`       | Close all tabs except the current one |

### Autocomplete

| VI Mode |     Keymap      | Action                                                              |
| :-----: | :-------------: | ------------------------------------------------------------------- |
| Insert  |  `CTRL` + `p`   | Turn on autocomplete and select the previous item                   |
| Insert  |  `CTRL` + `n`   | Turn on autocomplete and select the next item                       |
| Insert  | `SHIFT` + `TAB` | Turn on autocomplete only after a word and select the previous item |
| Insert  |      `TAB`      | Turn on autocomplete only after a word and select the next item     |
| Insert  |  `CTRL` + `b`   | Scroll up in the item documentation                                 |
| Insert  |  `CTRL` + `f`   | Scroll down in the item documentation                               |
| Insert  |  `CTRL` + `e`   | Abort the autocomplete menu                                         |

### Commenting

| VI Mode |     Keymap     | Action                    |
| :-----: | :------------: | ------------------------- |
| Normal  | `g` + `c`+ `c` | Comment the current line  |
| Visual  |   `g` + `c`    | Comment current selection |

### Moving Text

| VI Mode |     Keymap      | Action          |
| :-----: | :-------------: | --------------- |
| Normal  | `Alt` + `Left`  | Move char left  |
| Normal  | `Alt` + `Down`  | Move line down  |
| Normal  |  `Alt` + `Up`   | Move line up    |
| Normal  | `Alt` + `Right` | Move char right |

### Git Signs

|      VI Mode      |         Keymap         | Action                      |
| :---------------: | :--------------------: | --------------------------- |
|      Normal       |       `[` + `h`        | Go to the previous hunk     |
|      Normal       |       `]` + `h`        | Go to the next hunk         |
| Normal and Visual | `<leader>` + `h` + `p` | Preview the current hunk    |
| Normal and Visual | `<leader>` + `h` + `u` | Undo the current stage hunk |
| Normal and Visual | `<leader>` + `h` + `s` | Stage the current hunk      |
| Normal and Visual | `<leader>` + `h` + `r` | Reset the current hunk      |

### Diagnostics

| VI Mode |         Keymap         | Action                            |
| :-----: | :--------------------: | --------------------------------- |
| Normal  |          `K`           | Show hover documentation          |
| Normal  |       `g` + `d`        | Go to definition                  |
| Normal  | `<leader>` + `s` + `r` | Rename the current symbol         |
| Normal  | `<leader>` + `d` + `l` | Show list of diagnostics          |
| Normal  |       `[` + `d`        | Go to previous diagnostic         |
| Normal  |       `]` + `d`        | Go to next diagnostic             |
| Normal  | `<leader>` + `d` + `p` | Preview of the current diagnostic |
| Normal  | `<leader>` + `c` + `a` | Show current code actions         |

### Debugging

| VI Mode |      Keymap       | Action                                  |
| :-----: | :---------------: | --------------------------------------- |
| Normal  |      `<F9>`       | Toggle breakpoint on the current line   |
| Normal  |      `<F5>`       | Run and debug                           |
| Normal  | `SHIFT` + `<F5>`  | Terminate the current debugging session |
| Normal  |      `<F6>`       | Debug pause                             |
| Normal  |      `<F10>`      | Debug step over                         |
| Normal  |      `<F11>`      | Debug step into                         |
| Normal  | `SHIFT` + `<F11>` | Debug step out                          |

NOTE: Only custom keymaps unique to this configuration are documented here. There are many more keymaps available by default in each installed plugin, in addition to the hundreds that come with Vim by default.

## Recommendations

### Fonts

In order for the **[Enfocado](https://wuelnerdotexe.github.io/enfocado)'s Human Writing** feature work as it should, I recommend that you use either of these three beautiful fonts, which align with the **"Mankind and Machine"** concept.

- [IBM Plex Mono](https://www.ibm.com/plex/).
- [Victor Mono](https://rubjo.github.io/victor-mono/).

## Maintainer

> Hi 👋, I'm **[Wuelner](https://linktr.ee/wuelnerdotexe)**, a **software developer from Guatemala**, passionate about creating minimalist solutions using solid fundamentals focused on **"how things should be"**.

## License

[GPL-3.0 &copy; Wuelner Martínez.](https://github.com/wuelnerdotexe/nvim/blob/main/LICENSE)

<p align="center">With 💖 from <strong>LATAM</strong> to the world!</p>
