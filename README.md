<div align="center">

<img src="icon.svg" width="112" alt="checklist-tui icon">

# checklist-tui

*A tiny click-to-tick checklist for the terminal*

[![Python](https://img.shields.io/badge/Python-3.10+-3776ab?style=flat-square&logo=python&logoColor=white)](https://www.python.org)
[![Textual](https://img.shields.io/badge/built_with-Textual-5a4fcf?style=flat-square)](https://textual.textualize.io/)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue?style=flat-square)](LICENSE)

[Features](#features) • [Install](#install) • [Usage](#usage) • [The file](#the-file) • [Settings](#settings)

</div>

Several lists, priority items and in-place editing, all saved to one plain Markdown file. You can edit that file by hand, or let a script or an AI agent append to it: the app picks up changes within a second.

## Features

- **Lists as tabs:** switch with a click or <kbd>Ctrl</kbd>+<kbd>←</kbd>/<kbd>→</kbd>; pin the ones you use most so they stay first.
- **Always ready to type:** the add box has focus, so typing and pressing Enter adds an item.
- **Priority items:** a red box, sorted to the top. Start an item with `!` or press <kbd>Shift</kbd>+<kbd>Enter</kbd>.
- **Mouse or keyboard:** tick, open, edit, move and delete items either way.
- **Plain Markdown storage:** `- [ ]` / `- [x]` task lines under `##` headings; readable and diff-friendly.
- **Live reload:** edits made to the file elsewhere show up within a second.
- **Safety net:** a deleted list is appended to `checklist.deleted.md` beside your lists instead of vanishing.
- **Single file, one dependency:** `checklist.py` and [Textual](https://textual.textualize.io/).

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/nockesocks/checklist-tui/main/install.sh | sh
```

Then run `checklist` in any terminal. Run the same line again to update.

The installer downloads `checklist.py`, refuses to install it if it isn't valid Python, and links the command:

| What | Where |
|---|---|
| App | `~/.local/share/checklist/checklist.py` (or `$XDG_DATA_HOME/checklist/`) |
| Command | `~/.local/bin/checklist` |
| Your lists | `~/.local/share/checklist/checklist.md` by default |
| Settings, colours | `~/.config/checklist/` (or `$XDG_CONFIG_HOME/checklist/`) |

### Requirements

- Python 3.10 or newer
- [Textual](https://textual.textualize.io/) (tested with 8.2): `sudo pacman -S python-textual` on Arch, or `python3 -m pip install --user textual`
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal, for the icons

> [!NOTE]
> `~/.local/bin` must be on your `PATH`. The installer tells you if it isn't.

### Uninstall

```sh
sh install.sh --uninstall
```

This removes the app and the command. Your lists and settings are left alone.

## Usage

```sh
checklist                  # the file from settings
checklist ~/notes/todo.md  # another file, for this run only
checklist --help
```

### Mouse

| Click | Does |
|---|---|
| Chevron (top left) | Every list: open, pin, or (pencil) rename and delete |
| A list name | Opens it; click the open one to rename it |
| `…` | More lists than fit; opens the same menu |
| `+` / gear | New list / settings |
| Tick box | Done / not done |
| An item | Its card: toggle priority, move to another list, click the text to edit |
| Right-click an item | Edit it in place (empty text removes it) |
| `!` (bottom right) | The next item you add is priority |
| Empty space | Back to the add box |

### Keys

| Key | Does |
|---|---|
| <kbd>Enter</kbd> | Add the typed item |
| <kbd>Shift</kbd>+<kbd>Enter</kbd> | Add it as priority |
| <kbd>↑</kbd> or <kbd>Tab</kbd> (from the add box) | Into the items |
| <kbd>↑</kbd> <kbd>↓</kbd> | Move between items |
| <kbd>Space</kbd> | Tick / untick |
| <kbd>Enter</kbd> (on an item) | Open its card |
| <kbd>e</kbd> | Edit in place |
| <kbd>!</kbd> | Toggle priority |
| <kbd>Del</kbd> | Remove |
| <kbd>m</kbd> (in a card) | Move to another list |
| <kbd>Ctrl</kbd>+<kbd>C</kbd> | The list menu (<kbd>↑</kbd> <kbd>↓</kbd> <kbd>Enter</kbd>) |
| <kbd>Ctrl</kbd>+<kbd>S</kbd> | Settings |
| <kbd>Ctrl</kbd>+<kbd>←</kbd>/<kbd>→</kbd> | Previous / next list |
| <kbd>Esc</kbd> | Back out; focus returns where you came from |
| <kbd>Ctrl</kbd>+<kbd>Q</kbd> | Quit |

> [!TIP]
> Typing while an item has focus goes straight to the add box, so you never have to click back to it.

## The file

Each `##` heading is a list; a 📌 marks a pinned one, and `! ` marks a priority item:

```markdown
## 📌 UI changes
- [ ] ! rounder corners
- [x] cheat sheet

## ToDo
- [ ] call the bank
```

Lines that aren't headings or task lines are dropped when the app saves, so keep notes elsewhere.

> [!IMPORTANT]
> The default file is `~/.local/share/checklist/checklist.md`. Change it under **Settings → save file**: an existing checklist at the new path is opened; otherwise your current lists are saved there. A folder path saves `checklist.md` inside it.

## Settings

Open them with the gear or <kbd>Ctrl</kbd>+<kbd>S</kbd>. They are saved, along with the open list, to `~/.config/checklist/settings.json`.

| Setting | Default | Does |
|---|---|---|
| Word wrap | on | Long items wrap; off cuts them with `…` |
| Growing input | off | The add box grows up to 8 lines as you type |
| Show ticked | on | Off hides done items |
| Save file | `~/.local/share/checklist/checklist.md` | Where your lists live |

### Colours

The app uses Catppuccin Mocha colours by default. To theme it, put a JSON file at `~/.config/checklist/palette.json` with any of these keys as `#rrggbb` values: `base`, `mantle`, `crust`, `surface0`, `surface1`, `overlay0`, `subtext0`, `text`, `red`, `accent` (highlights), `accentText` and `tick` (ticked boxes).

```json
{ "base": "#1e1e2e", "text": "#cdd6f4", "accent": "#533e79", "tick": "#9a86cd" }
```

## Developing

This checkout is the source, not what runs. After changing `checklist.py`, install your copy:

```sh
sh install.sh --local
```

`CHECKLIST_REPO` and `CHECKLIST_REF` point the installer at a fork or branch.
