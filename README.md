# nvim

My personal but distributable Neovim setup written in Lua.

## Keymaps

The keymaps created by this setup are very well thought out to be intuitive, meaningful, and most of all, to stick to the essence of Vim.
Keymaps are normally assigned two letters, which signify an action, for example: `d` + `p` = [D]diagnostic [P]review. Keep in mind that the functionality will always come first and then the action.
This is the standard created and used by this configuration for unique consistency.

IMPORTANT: The `\` backslash remains as the global `<leader>` leadermap.

### General

|       VI Mode       |         Keymap         | Action                               |
| :-----------------: | :--------------------: | ------------------------------------ |
|       Normal        | `<leader>` + `f` + `t` | Toggle file explorer                 |
|       Normal        | `<leader>` + `f` + `r` | Reveal current file in file explorer |
|       Normal        | `<leader>` + `f` + `f` | Find files in the current directory  |
| Normal and Terminal | `<leader>` + `t` + `t` | Toggle bottom terminal               |

### File Explorer

| VI Mode |   Keymap    | Action                |
| :-----: | :---------: | --------------------- |
| Normal  |     `<`     | Leave directory       |
| Normal  |     `>`     | Enter directory       |
| Normal  |  `w` + `d`  | Set working directory |
| Normal  |   `ENTER`   | Expand or open node   |
| Normal  | `BACKSPACE` | Collapse node         |
| Normal  |  `t` + `o`  | Open in a new tab     |
| Normal  |  `s` + `o`  | Open to the side      |
| Normal  |     `V`     | Toggle mark           |
| Normal  |  `ESCAPE`   | Clear marks           |
| Normal  |     `n`     | New path              |
| Normal  |  `n` + `f`  | New file              |
| Normal  |  `n` + `d`  | New directory         |
| Normal  |     `m`     | Move node             |
| Normal  |     `c`     | Copy node             |
| Normal  |     `d`     | Delete node           |
| Normal  |   `<F5>`    | Refresh explorer      |

### Windows

| VI Mode |         Keymap         | Action                         |
| :-----: | :--------------------: | ------------------------------ |
| Normal  |      `CTRL` + `h`      | Resize the window on the left  |
| Normal  |      `CTRL` + `j`      | Resize the window on the down  |
| Normal  |      `CTRL` + `k`      | Resize the window on the up    |
| Normal  |      `CTRL` + `l`      | Resize the window on the right |
| Normal  | `<leader>` + `m` + `t` | Toggle maximizer window        |

### Buffers

| VI Mode |        Keymap         | Action                                   |
| :-----: | :-------------------: | ---------------------------------------- |
| Normal  |       `g` + `B`       | Go to previous buffer                    |
| Insert  |  `SHIFT` + `PAGE UP`  | Go to previous buffer                    |
| Normal  |       `g` + `b`       | Go to next buffer                        |
| Insert  | `SHIFT` + `PAGE DOWN` | Go to next buffer                        |
| Normal  |       `d` + `b`       | Delete the current buffer                |
| Normal  |       `1` + `b`       | Close all buffers except the current one |
| Normal  |       `m` + `B`       | Move buffer left                         |
| Normal  |       `m` + `b`       | Move buffer right                        |
| Normal  |    `g` + `p` + `b`    | Go to pick buffer                        |
| Normal  |    `c` + `p` + `b`    | Close pick buffer                        |

### Tabs

| VI Mode |        Keymap        | Action                                |
| :-----: | :------------------: | ------------------------------------- |
| Normal  |      `g` + `T`       | Go to the previous tab                |
| Insert  |  `CTRL` + `PAGE UP`  | Go to the previous tab                |
| Normal  |      `g` + `t`       | Go to the next tab                    |
| Insert  | `CTRL` + `PAGE DOWN` | Go to the next tab                    |
| Normal  |      `c` + `t`       | Close the current tab                 |
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

| VI Mode |     Keymap      | Action                    |
| :-----: | :-------------: | ------------------------- |
| Normal  | `g` + `c`+ `c`  | Comment the current line  |
| Normal  | `g` + `b` + `c` | Comment the current block |
| Visual  |    `g` + `c`    | Comment current selection |

### Gitsigns

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

NOTE: Only custom keymaps unique to this configuration are documented here. There are many more keymaps available by default in each installed plugin, in addition to the hundreds that come with Vim by default.
