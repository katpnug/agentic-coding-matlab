# 1. Set up MATLAB and your IDE

*Time: 20–40 minutes (mostly waiting on installers). Do this before the workshop.*

You need three layers, installed in this order:

1. **MATLAB** (this page)
2. **An IDE** — VS Code *or* Antigravity (this page)
3. **An AI agent** inside the IDE → [next page](02-setup-agent.md)
4. **The MATLAB MCP server** connecting agent ↔ MATLAB → [page 3](03-setup-matlab-mcp.md)

## 1.1 MATLAB

- You need **MATLAB R2021a or newer** installed locally with a valid license
  (a campus/institutional license is fine). R2023a or newer is recommended —
  it enables the nicer "connect to my open MATLAB session" mode.
- No special toolboxes are required for this course; everything uses base
  MATLAB functions (`load`, `histcounts`, `plot`, …).
- **Add MATLAB to your system PATH** so other programs can find it:
  - *Windows*: the installer has an "Add MATLAB to PATH" checkbox. If you
    missed it: Start menu → "Edit the system environment variables" →
    Environment Variables → edit `Path` → add
    `C:\Program Files\MATLAB\R2024b\bin` (match your version).
  - *macOS/Linux*: add the MATLAB `bin` folder to PATH in your shell profile,
    e.g. `export PATH="/Applications/MATLAB_R2024b.app/bin:$PATH"`.
- **Verify:** open a fresh terminal (Windows: PowerShell) and run
  `matlab -batch "disp(2+2)"`. You should see `4` after a few seconds. If you
  get "matlab is not recognized", PATH isn't set — see
  [troubleshooting](troubleshooting.md).

## 1.2 Option A — Visual Studio Code (recommended default)

VS Code is a free editor that nearly every coding agent supports.

1. Download and install from <https://code.visualstudio.com/>.
2. Open VS Code → Extensions panel (square icon in the left bar, or
   `Ctrl+Shift+X`).
3. Install **"MATLAB"** (publisher: *MathWorks*). This gives syntax
   highlighting, code checking, and lets you run MATLAB files from the editor.
   - After installing, open VS Code settings (`Ctrl+,`), search for
     "matlab installation", and set **MATLAB: Installation Path** to your
     MATLAB folder (e.g. `C:\Program Files\MATLAB\R2024b`) if it isn't
     auto-detected.
4. `File → Open Folder…` and open your clone of this repository. When VS Code
   asks whether you trust the folder, say yes.

📷 *[screenshot placeholder: VS Code with the MATLAB extension installed and this repo open]*

## 1.3 Option B — Antigravity

[Antigravity](https://antigravity.google/) is Google's agent-first IDE (a VS
Code derivative with the Gemini agent built in). Choose it if your lab/license
situation favors Gemini.

1. Download and install from <https://antigravity.google/>.
2. Sign in with a Google account when prompted.
3. It supports the same VS Code extensions: install the **MATLAB** extension
   from the extension marketplace as in Option A step 3.
4. `File → Open Folder…` → open your clone of this repository.

## 1.4 Get this repository

If you have git: `git clone <repo URL>` wherever you keep code.
If you don't: on the repo's GitHub page click **Code → Download ZIP** and
unzip it somewhere sensible (not in Downloads). Either way, this folder is
what you open in your IDE.

✅ **Checkpoint:** MATLAB runs from a terminal, your IDE opens this folder,
and `.m` files show colored syntax. Next: [2. Set up your agent](02-setup-agent.md)
