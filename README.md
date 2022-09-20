# nvim

My personal but distributable Neovim setup written in Lua.

## Keymaps

The `\` backslash remains as the global `<leader>` leadermap.

### General

|        Mode         |         Keymap         | Action                                       |
| :-----------------: | :--------------------: | -------------------------------------------- |
|       Normal        | `<leader>` + `f` + `t` | Toggle the file explorer                     |
|       Normal        | `<leader>` + `f` + `r` | Reveal the current file in the file explorer |
|       Normal        | `<leader>` + `f` + `f` | Find files in the current directory          |
| Normal and Terminal | `<leader>` + `t` + `t` | Toggle the bottom terminal                   |

### File Explorer

|  Mode  |   Keymap    | Action               |
| :----: | :---------: | -------------------- |
| Normal |     `<`     | Leave the directory  |
| Normal |     `>`     | Enter the directory  |
| Normal |   `ENTER`   | Expand or open node  |
| Normal | `BACKSPACE` | Collapse node        |
| Normal |  `t` + `o`  | Open in a new tab    |
| Normal |  `s` + `o`  | Open to the side     |
| Normal |     `n`     | New path             |
| Normal |  `n` + `f`  | New file             |
| Normal |  `n` + `d`  | New directory        |
| Normal |     `c`     | Copy node            |
| Normal |     `m`     | Move node            |
| Normal |     `d`     | Delete node          |
| Normal |     `V`     | Toggle mark          |
| Normal |  `ESCAPE`   | Clear marks          |
| Normal |   `<F5>`    | Refresh the explorer |

### Windows

|  Mode  |         Keymap         | Action                     |
| :----: | :--------------------: | -------------------------- |
| Normal |      `CTRL` + `h`      | Resize the window to left  |
| Normal |      `CTRL` + `j`      | Resize the window to down  |
| Normal |      `CTRL` + `k`      | Resize the window to up    |
| Normal |      `CTRL` + `l`      | Resize the window to right |
| Normal | `<leader>` + `m` + `t` | Toggle maximizer window    |

### Buffers

|  Mode  |        Keymap         | Action                               |
| :----: | :-------------------: | ------------------------------------ |
| Normal |       `g` + `B`       | Go to the previous buffer            |
| Insert |  `SHIFT` + `PAGE UP`  | Go to the previous buffer            |
| Normal |       `g` + `b`       | Go to the next buffer                |
| Insert | `SHIFT` + `PAGE DOWN` | Go to the next buffer                |
| Normal |       `d` + `b`       | Delete the current buffer            |
| Normal |       `1` + `b`       | Close all buffers except the current |
| Normal |       `m` + `B`       | Move buffer to the left              |
| Normal |       `m` + `b`       | Move buffer to the right             |
| Normal |    `g` + `p` + `b`    | Go to pick buffer                    |
| Normal |    `c` + `p` + `b`    | Close the pick buffer                |

### Tabs

|  Mode  |        Keymap        | Action                            |
| :----: | :------------------: | --------------------------------- |
| Normal |      `g` + `T`       | Go to the previous tab            |
| Insert |  `CTRL` + `PAGE UP`  | Go to the previous tab            |
| Normal |      `g` + `t`       | Go to the next tab                |
| Insert | `CTRL` + `PAGE DOWN` | Go to the next tab                |
| Normal |      `c` + `t`       | Close the current tab             |
| Normal |      `1` + `t`       | Close all tabs except the current |

### Autocomplete

|  Mode  |     Keymap      | Action                                                                  |
| :----: | :-------------: | ----------------------------------------------------------------------- |
| Insert |  `CTRL` + `p`   | Trigger the autocomplete and select the previous item                   |
| Insert |  `CTRL` + `n`   | Trigger the autocomplete and select the next item                       |
| Insert | `SHIFT` + `TAB` | Trigger the autocomplete only after a word and select the previous item |
| Insert |      `TAB`      | Trigger the autocomplete only after a word and select the next item     |
| Insert |  `CTRL` + `b`   | Scroll up in the item docs                                              |
| Insert |  `CTRL` + `f`   | Scroll down in the item docs                                            |
| Insert |  `CTRL` + `e`   | Abort the autocomplete menu                                             |

### Gitsigns

|       Mode        |         Keymap         | Action                      |
| :---------------: | :--------------------: | --------------------------- |
|      Normal       |       `[` + `h`        | Go to the previous hunk     |
|      Normal       |       `]` + `h`        | Go to the next hunk         |
| Normal and Visual | `<leader>` + `h` + `s` | Stage the current hunk      |
| Normal and Visual | `<leader>` + `h` + `r` | Reset the current hunk      |
| Normal and Visual | `<leader>` + `h` + `u` | Undo the current stage hunk |
| Normal and Visual | `<leader>` + `h` + `p` | Preview the current hunk    |

### Diagnostics

|  Mode  |         Keymap         | Action                         |
| :----: | :--------------------: | ------------------------------ |
| Normal | `<leader>` + `d` + `p` | Preview the current diagnostic |
| Normal | `<leader>` + `c` + `a` | Show current code actions      |
| Normal | `<leader>` + `s` + `r` | Rename the current symbol      |
| Normal | `<leader>` + `d` + `l` | Show diagnostics list          |
| Normal |          `K`           | Show documentation             |
| Normal |       `[` + `d`        | Go to the previous diagnostic  |
| Normal |       `]` + `d`        | Go to the next diagnostic      |
| Normal |       `g` + `d`        | Go to definition               |
