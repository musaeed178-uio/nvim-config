# DopaVim Keymaps Manual

A practical guide to the everyday keymaps in this config. `<leader>` is the
**Space** key (LazyVim default), so `<leader>ff` means press Space, then f, then f.

`<M-x>` means Alt+x. `:` means command-line mode.

Tip: press `<leader>?` at any time to see all keymaps active for the current
buffer (which-key popup). `<c-w><space>` shows the window keymaps.

------------------------------------------------------------------------

## 1. Formatting a file

| Key | What it does |
|---|---|
| `<leader>cf` | Format the whole file (or visual selection) right now |
| `<leader>cf` (visual) | Format only the selected lines |

This works no matter whether autoformat on write is on or off, because it
forces the format. If no formatter is installed for that filetype you get a
"no formatter available" warning.

Other code keys:

| Key | What it does |
|---|---|
| `<leader>ca` | Code action (quick fix / refactor suggestions) |
| `<leader>cr` | Rename symbol (across the project) |
| `<leader>cl` | LSP info for the current buffer |
| `<leader>cm` | Mason (install LSP servers / formatters / linters) |
| `<leader>cs` | Symbols outline (Trouble) |
| `<leader>cv` | Select Python virtualenv (Python files only) |

------------------------------------------------------------------------

## 2. Autoformat on write (on / off)

By default this config **starts with autoformat OFF** (`vim.g.autoformat =
false` in `lua/config/options.lua`), so saving does not touch your formatting
until you turn it on.

| Key | What it does |
|---|---|
| `<leader>uf` | Toggle autoformat **globally** (all files) |
| `<leader>uF` | Toggle autoformat for the **current buffer only** |
| `<leader>cf` | Format once, manually (always works) |

How to use it day to day:

1. Open a file.
2. Press `<leader>uf` to switch autoformat on — you get a notification saying
   "Auto Format (Global) enabled".
3. Now every `:w` runs the formatter first (`BufWritePre` hook from LazyVim).
4. Press `<leader>uf` again to turn it off.

`<leader>uF` is per-buffer: useful when you want one messy file left exactly
as it is while the rest of the project still auto-formats. The buffer setting
overrides the global one.

Check the current state any time with `:LazyFormatInfo`.

------------------------------------------------------------------------

## 3. Find and replace

### In the current file

Standard Vim still applies:

- `/text` then Enter — search forward, `n` / `N` for next / previous match.
- `:%s/old/new/g` — replace every `old` with `new` in the file.
- `:s/old/new/g` on a visual selection — replace inside the selection.

### Across the whole project (grug-far)

| Key | What it does |
|---|---|
| `<leader>sr` (normal) | Open project-wide search & replace, filter pre-filled with the current file's extension |
| `<leader>sr` (visual) | Same, but the search field is pre-filled with your selection |

Inside the grug-far window:

1. The **search** buffer is already focused — type the text to find.
2. Press Tab (or click) to move to the **replace** buffer, type the
   replacement.
3. The **files filter** line limits which files are touched (for example
   `*.py`). Clear it to search everything.
4. Press the key shown in the window header to run — `S` applies all
   replacements, `R` replaces one at a time so you can review each hit.
5. `q` closes the window.

### Search helpers (Telescope)

| Key | What it does |
|---|---|
| `<leader>sg` | Grep the whole project (live) |
| `<leader>sG` | Grep from the current directory instead of project root |
| `<leader>sw` | Grep for the word under the cursor |
| `<leader>sW` | Same, but from the current directory |
| `<leader>sw` (visual) | Grep for the selected text |
| `<leader>/` | Same as `<leader>sg` (quick grep) |
| `<leader>sb` | Fuzzy search inside the current file |
| `<leader>sR` | Resume the last Telescope search |

Inside a Telescope list: `<C-q>` sends everything to the quickfix list, then
use `:copen` to see it, `[q` / `]q` to move between entries, and
`:cfdo %s/old/new/g` to replace in all of them at once.

------------------------------------------------------------------------

## 4. lazygit and git

### lazygit itself

| Key | What it does |
|---|---|
| `<leader>gg` | Open lazygit for the project root |
| `<leader>gG` | Open lazygit for the current directory |

Inside lazygit (its own UI, not Neovim):

- `Space` — second window (diff / commit log).
- `1` / `2` / `3` / `4` — switch between status, log, stash, commit views.
- `n` — next item, `N` or `p` — previous item (context dependent).
- `a` — add/unstage a file, `c` — commit (type message, `Ctrl+Enter` or
  `w` to confirm), `P` — push, `f` — fetch, `r` — rebase menu.
- `d` — discard, `s` — squash, `y` — copy the commit hash.
- `?` — show all lazygit keybindings.
- `q` — quit back to Neovim.

Note: `<leader>gg` / `<leader>gG` only exist if `lazygit` is on your PATH.

### Git without leaving Neovim

| Key | What it does |
|---|---|
| `<leader>gs` | Git status (Telescope) |
| `<leader>gc` / `<leader>gl` | Commit list |
| `<leader>gS` | Stash list |
| `<leader>gf` | History of the current file |
| `<leader>gb` | Blame the line under the cursor |
| `<leader>gB` | Open the file on GitHub / GitLab in a browser |
| `<leader>gY` | Copy that URL instead of opening it |
| `<leader>ghs` | Stage the hunk under the cursor |
| `<leader>ghr` | Reset the hunk under the cursor |
| `<leader>ghp` | Preview the hunk inline |
| `<leader>ghb` | Blame line (full message) |
| `<leader>ghd` | Diff this file against its index |
| `]h` / `[h` | Next / previous changed hunk |
| `<leader>uG` | Toggle the git signs in the sign column |

------------------------------------------------------------------------

## 5. Jupyter notebooks (.ipynb) — the big one

Opening a `.ipynb` file loads it as a real notebook (ipynb.nvim). You get two
modes:

- **Notebook mode** — the notebook view: each cell is a block, outputs are
  rendered as read-only lines, cell borders show hints.
- **Cell mode** — you are actually editing one cell's text, in a float over
  the notebook. `<Esc>` takes you back to Notebook mode.

### Moving around and editing cells (Notebook mode)

| Key | What it does |
|---|---|
| `]]` / `[[` | Jump to next / previous cell |
| `<CR>` | Open the cell under the cursor (Normal mode) |
| `i` / `a` | Open cell and insert before / after (goes straight to insert) |
| `I` / `A` | Open cell and insert at start / end of first line |
| `o` / `O` | Open cell and open a new line below / above |
| `dd` | Cut (delete) the whole cell |
| `p` / `P` | Paste the cut cell below / above the current one |
| `<M-j>` / `<M-k>` | Move the current cell down / up (Alt+j / Alt+k) |

### Executing cells and the kernel

| Key | What it does |
|---|---|
| `<C-CR>` | Execute the current cell, stay on it (works in both modes) |
| `<S-CR>` | Execute and move to the next cell (works in both modes) |
| `<M-CR>` | Execute and insert a new cell below (Notebook mode) |
| `<C-c>` | Interrupt the running kernel |
| `<leader>ks` | Start the kernel |
| `<leader>k0` | Restart the kernel |
| `<leader>kS` | Shut the kernel down |
| `<leader>ki` | Interrupt (menu version of `<C-c>`) |
| `<leader>kn` | Kernel status/info |
| `<leader>kx` | Execute cell (menu version of `<C-CR>`) |
| `<leader>kX` | Execute and move next (menu version of `<S-CR>`) |

### Cell structure (`<leader>k` menu)

| Key | What it does |
|---|---|
| `<leader>ka` | Add a new cell **above** |
| `<leader>kb` | Add a new cell **below** |
| `<leader>km` | Turn the current cell into Markdown |
| `<leader>ky` | Turn the current cell into code |
| `<leader>kr` | Turn the current cell into raw |
| `<leader>kj` | Jump to cell — opens a picker listing every cell |
| `<leader>kf` | Fold / unfold the current cell (Notebook mode) |
| `u` / `<C-r>` | Undo / redo (global across cells, both modes) |

### Outputs

| Key | What it does |
|---|---|
| `<leader>ko` | Open the cell's output in a float (easy to copy) |
| `<leader>kc` | Clear the current cell's output |
| `<leader>kC` | Clear **all** outputs in the notebook |
| `Y` (on an output line) | Yank that output line (virtual lines can't be yanked normally) |

### Inspecting variables

| Key | What it does |
|---|---|
| `<leader>kh` | Inspect the variable under the cursor |
| `<leader>kv` | List every variable in the current cell |
| `<leader>kH` | Toggle auto-hover (hover info follows the cursor) |

### Inside a cell (Cell mode)

| Key | What it does |
|---|---|
| `<Esc>` | Close the cell, back to Notebook mode |
| `<C-j>` / `<C-k>` | Jump to the next / previous cell (stays in cell mode) |
| `<C-CR>` / `<S-CR>` | Execute cell (stay / move next) |
| `u` / `<C-r>` | Undo / redo |
| `i` etc. | Normal insert-mode editing inside the cell |

LSP keys (`gd`, `gr`, `K`, `<leader>ca`, `<leader>cr`, `<leader>cf`) also
work inside cells — completion is available with `<C-Space>`.

### Useful notebook commands (command mode)

- `:NotebookCreate analysis.ipynb` — create a new notebook.
- `:NotebookSave` — save it.
- `:NotebookExecuteAll` — run every code cell.
- `:NotebookExecuteAllBelow` — run this cell and everything under it.
- `:NotebookFormatCell` / `:NotebookFormatAll` — format code via the LSP.
- `:NotebookSetKernel python3` — change the kernel.
- `:NotebookListKernels` — see installed kernels.
- `:NotebookToggleCellType` — flip code <-> markdown.

All of them have a keymap where one exists — see the tables above.

------------------------------------------------------------------------

## 6. Terminals (floating)

| Key | What it does |
|---|---|
| `Alt+i` | Toggle a floating **PowerShell** terminal (pwsh on Windows) |
| `Alt+c` | Toggle a floating **default shell** terminal (cmd.exe on Windows) |
| `Alt+b` | Toggle a floating **Git Bash** terminal |

Inside any floating terminal:

| Key | What it does |
|---|---|
| `Alt+i` / `Alt+c` / `Alt+b` | Hide that terminal again (same key that opened it) |
| `Esc` | Leave terminal mode, get your cursor back |

Other terminal bits:

| Key | What it does |
|---|---|
| `<leader>ft` | Snacks terminal in the project root |
| `<leader>fT` | Snacks terminal in the current directory |
| `<c-/>` | Focus the terminal (or open it) |
| `<Esc>` in a Snacks terminal | Close it |

The floating terminals follow your working directory: if you move to another
project while it is open, the shell gets a `cd` to the new root when you
reopen it.

------------------------------------------------------------------------

## 7. Files, finders and the file explorer

| Key | What it does |
|---|---|
| `<leader>ff` | Find files (project root) |
| `<leader>fF` | Find files (current directory) |
| `<leader><space>` | Same as `<leader>ff` |
| `<leader>fg` | Find files tracked by git |
| `<leader>fr` | Recent files |
| `<leader>fR` | Recent files in the current directory |
| `<leader>fb` | Buffers (recently used first) |
| `<leader>fB` | All buffers |
| `<leader>fc` | Files in the Neovim config |
| `<leader>fP` | Files in the installed plugins |
| `<leader>fp` | Projects (project.nvim list) |
| `-` | Open the **oil** file explorer (floating) |

Inside oil:

| Key | What it does |
|---|---|
| `<CR>` | Open the file / directory under the cursor |
| `-` | Go to the parent directory |
| `q` | Close |
| `i` / `a` etc. | Normal Vim editing — oil edits the directory listing like a buffer |
| `<C-h/j/k/l>` | Move between windows while oil is open |

Anything else in oil (create a file, rename, delete) is plain Vim: `o` to
open a line and type the new filename, `dd` to delete (goes to trash),
`R` to rename. Save with `:w`.

Telescope list keymaps: `<C-n>` / `<C-p>` move, `<CR>` opens,
`<C-v>` vertical split, `<C-x>` horizontal split, `<C-t>` opens in a tab,
`<C-q>` sends to quickfix, `q` or `<Esc>` closes.

------------------------------------------------------------------------

## 8. Buffers, windows and tabs

| Key | What it does |
|---|---|
| `<leader>1` ... `<leader>9` | Jump straight to buffer 1-9 (bufferline) |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `<leader>tp` / `<leader>tn` | Previous / next buffer (your own aliases) |
| `<leader>bb` | Switch to the other (alternate) buffer |
| `<leader>bd` | Delete the current buffer |
| `<leader>bo` | Delete all other buffers |
| `<leader>bD` | Delete buffer and window |
| `<leader>bj` | Pick a buffer by label |
| `<leader>bp` | Pin the current buffer |
| `<leader>to` | New tab |

Splits:

| Key | What it does |
|---|---|
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>-` | Split below |
| `<leader>|` | Split right |
| `<leader>wd` | Close the current window |
| `<C-h/j/k/l>` | Move to the window left / down / up / right |
| `<C-Up/Down/Left/Right>` | Resize the window |
| `<leader>wm` | Zoom (maximize) the current window |
| `<leader>uz` | Zen mode |

------------------------------------------------------------------------

## 9. Everyday editing (this config's own keymaps)

| Key | What it does |
|---|---|
| `<leader>a` | Select the entire file |
| `<leader>Y` | Yank the entire file (cursor does not move) |
| `<leader>d` (normal) | Delete without yanking — wait for a motion (`<leader>dw`, `<leader>d$`...) |
| `<leader>d` (visual) | Delete the selection without yanking it |
| `p` / `P` (visual) | Paste over the selection without overwriting the yank register |
| `zh` / `zl` | Scroll 6 columns left / right |
| `<A-j>` / `<A-k>` | Move the current line / selection down / up |
| `<C-s>` | Save the file |
| `gc` | Comment the line (motion or, in visual, the selection) |
| `gcc` | Comment the line |
| `gco` / `gcO` | Add a comment line below / above |
| `s` | Flash jump — type letters to teleport to any visible position |
| `y` / `p` / `P` | Normal yank/put, but backed by yanky's history |
| `[y` / `]y` | Cycle back / forward through yank history |
| `<leader>p` | Open the yank history picker |
| `<Esc>` | Clear search highlight and stop completion |

------------------------------------------------------------------------

## 10. LSP navigation

| Key | What it does |
|---|---|
| `gd` | Go to definition |
| `gr` | References |
| `gI` | Implementation |
| `gy` | Type definition |
| `gD` | Declaration |
| `K` | Hover documentation |
| `gK` | Signature help |
| `<C-k>` (insert) | Signature help |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cd` | Show line diagnostics in a float |
| `]d` / `[d` | Next / previous diagnostic |
| `]e` / `[e` | Next / previous error |
| `]w` / `[w` | Next / previous warning |
| `]]` / `[[` | Next / previous reference under the cursor (while highlighted) |
| `<leader>xx` | All diagnostics in Trouble |
| `<leader>xX` | Buffer diagnostics in Trouble |

------------------------------------------------------------------------

## 11. UI toggles (`<leader>u` group)

| Key | What it does |
|---|---|
| `<leader>uf` | Autoformat (global) — see section 2 |
| `<leader>uF` | Autoformat (buffer) |
| `<leader>us` | Spell checking |
| `<leader>uw` | Line wrap |
| `<leader>ul` | Line numbers |
| `<leader>uL` | Relative line numbers |
| `<leader>ud` | Diagnostics |
| `<leader>uc` | Conceal level |
| `<leader>ub` | Light / dark background |
| `<leader>uT` | Tree-sitter highlighting |
| `<leader>ug` | Indent guides |
| `<leader>uG` | Git signs |
| `<leader>ua` | Animation |
| `<leader>uh` | Inlay hints |
| `<leader>uz` | Zen mode |
| `<leader>uZ` | Zoom window |
| `<leader>uC` | Colorscheme picker with preview |
| `<leader>ui` | Inspect the highlight group under the cursor |
| `<leader>uI` | Treesitter inspect tree |
| `<leader>un` | Dismiss all notifications |
| `<leader>ur` | Redraw / clear search highlight |

Other odds and ends:

| Key | What it does |
|---|---|
| `<leader>h` | Toggle the dashboard on / off in this window |
| `<leader>l` | Open lazy (plugin manager) |
| `<leader>qq` | Quit everything |
| `<leader>qs` | Restore the last session |
| `<leader>qS` | Pick a session to restore |
| `<leader>ql` | Restore the most recent session |
| `<leader>qd` | Stop saving the current session |
| `<leader>fn` | New empty file |
| `<leader>L` | LazyVim changelog |
| `<leader>?` | Which-key: show this buffer's keymaps |

------------------------------------------------------------------------

## 12. Quick "how do I..." cheat sheet

- **Format this file:** `<leader>cf`
- **Stop it reformatting on save:** `<leader>uf` (toggle back on the same key)
- **Replace a word everywhere:** `<leader>sr`, type search, Tab, type
  replacement, then the apply key shown in the header
- **Open lazygit:** `<leader>gg`
- **Run the current notebook cell:** `<C-CR>` (stay) or `<S-CR>` (move next)
- **Start the notebook kernel:** `<leader>ks`
- **Add a cell below:** `<leader>kb`
- **Open a shell:** `Alt+i` (PowerShell) / `Alt+c` (cmd) / `Alt+b` (Git Bash)
- **Find a file:** `<leader>ff`
- **Search the project:** `<leader>sg`
- **Find anything you can't remember:** `<leader>?`
