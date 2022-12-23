# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.17.0] - 2022-12-23

### Changed

- The [emmet-vim](https://github.com/mattn/emmet-vim) plugin is replaced by [cmp-emmet](https://github.com/jackieaskins/cmp-emmet).
- Detection of `prettier` config files has been improved.
- The `eslint` and `prettier` save actions are removed.
- A new `PrettierFormatAll` command is created.

## [1.16.0] - 2022-12-20

### Added

- Folding handling enabled from `aerial`.
- Various optimizations are madded.

### Changed

- The `fzf-fuzzy` of `telescope` is turned off for exact results.

### Fixed

- Removed `packer` bootstrapping, due to conflict with `impatient` and performance.

## [1.15.0] - 2022-12-13

### Added

- Various code optimizations are madded.
- Discord presence blacklist removed.
- Multiple ui improvements are added.
- Added [vim-polygot](https://github.com/sheerun/vim-polyglot) plugin to the setup.
- Add `node` debugger and configuration to the setup.
- More keymaps for `treesitter` and `lsp` are added.

## [1.14.0] - 2022-11-30

### Added

- New borders are activated in `nvim-lspconfig` and `null-ls.nvim`.
- New plugins are added to **Enfocado**.

## [1.13.0] - 2022-11-29

### Added

- Performance optimizations are madded in `packer.nvim`.
- The `api.nvim` is now used for highlighting.

## [1.12.0] - 2022-11-18

### Changed

- Consistency and performance improvements are made.

## [1.11.0] - 2022-11-13

### Added

- Added automatic installers for all [null-ls](https://github.com/jayp0521/mason-null-ls.nvim) servers and the [nvim-dap](https://github.com/jayp0521/mason-nvim-dap) adapter.

## [1.10.0] - 2022-11-10

### Added

- Automatically enabled `EslintFixAll` on save.
- All symbols available in the outline and breadcrumbs are displayed.

### Changed

- The `lsp_formatting` function is optimized.
- Several small optimizations are made.

## [1.9.1] - 2022-11-08

### Fixed

- Fixed automatic installation of language servers.
- Tree-sitter grammars needed to avoid bugs are declared in [noice.nvim](https://github.com/folke/noice.nvim).
- Various optimizations are added.

## [1.9.0] - 2022-11-06

### Added

- Added [presence.nvim](https://github.com/andweeb/presence.nvim) plugin for Discord with funny messages (in Spanish).

## [1.8.0] - 2022-10-30

### Added

- Added [noice.nvim](https://github.com/folke/noice.nvim) and [SmoothCursor.nvim](https://github.com/gen740/SmoothCursor.nvim) to the setup for a smooth, fancy, and candy for a development experience (DX). Noice !!

## [1.7.0] - 2022-10-17

### Added

- Added [nvim-dap](https://github.com/mfussenegger/nvim-dap) to the setup.

### Changed

- Added multiple improvements for `dap`.

## [1.6.0] - 2022-10-11

### Added

The following dev dependencies are added to ensure code quality and consistency:

- [luacheck](https://github.com/lunarmodules/luacheck) - Lua linter.
- [stylua](https://github.com/JohnnyMorganz/StyLua) - Lua formatter.

## [1.5.0] - 2022-10-10

### Added

- Massive improvements have been added.

## [1.4.0] - 2022-10-01

### Added

- A new plugin is added to interact with tmux.

### Changed

- Keymaps to move text are standardized.

## [1.3.0] - 2022-09-27

### Added

- Multiple performance improvements are added for a better user experience.

## [1.2.0] - 2022-09-24

### Added

- Smooth scrolling is added to improve the experience in terminals. ¡Es hermosooo! 💖

## [1.1.3] - 2022-09-23

### Fixed

- Compatibility with the stable version of Neovim is added.

## [1.1.2] - 2022-09-23

### Fixed

- Optimized plugin startup sequence.
- Unnecessary loading of more plugins and providers is optimized.

## [1.1.1] - 2022-09-22

### Fixed

- Performance improvements are made.

## [1.1.0] - 2022-09-21

### Added

- Added documentation for keymaps.

### Fixed

- Multiple improvements and optimizations are made.

## [1.0.0] - 2022-09-12

- Initial release

<p align="center">With 💖 from <strong>LATAM</strong> to the world!</p>
