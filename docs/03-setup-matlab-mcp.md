# 3. Set up the MATLAB MCP server

*Time: 10–15 minutes. This is the step that connects your agent to MATLAB.*

We use the **official MATLAB MCP Core Server from MathWorks**:
<https://github.com/matlab/matlab-mcp-core-server>. It is a single small
program (no installer) that your agent launches in the background. Through it,
the agent gets five MATLAB tools:

- `detect_matlab_toolboxes` — list installed toolboxes
- `check_matlab_code` — static analysis of a `.m` file
- `evaluate_matlab_code` — run MATLAB commands
- `run_matlab_file` — run a `.m` script
- `run_matlab_test_file` — run unit tests

Requirements: MATLAB **R2021a or newer**, on your system PATH (you verified
this in [step 1](01-setup-ide.md)).

## 3.1 Download the server binary

Go to the [latest release page](https://github.com/matlab/matlab-mcp-core-server/releases/latest)
and download the file for your platform:

- Windows: `matlab-mcp-core-server-win64.exe`
- Linux: `matlab-mcp-core-server-glnxa64`
- macOS Apple silicon / Intel: `...-maca64` / `...-maci64`

Put it somewhere permanent (not Downloads), e.g.
`C:\tools\matlab-mcp-core-server-win64.exe` on Windows or
`~/tools/matlab-mcp-core-server` on macOS/Linux.

macOS/Linux only — make it executable:

```bash
chmod +x ~/tools/matlab-mcp-core-server
```

**Write down the full path to this file — you need it below.**

## 3.2 (Recommended, R2023a+) Enable "shared session" mode

By default the server can start its own invisible MATLAB. It is *much* nicer
to connect the agent to **your open MATLAB desktop**, so figures appear on
your screen and you share a workspace with the agent. One-time setup:

1. In a terminal, run the server once with the setup flag:

   ```powershell
   C:\tools\matlab-mcp-core-server-win64.exe --setup-matlab
   ```

   This installs a small add-on ("MATLAB MCP Core Server Toolbox") into MATLAB.
2. From now on, whenever you work with the agent, have MATLAB open and run
   this once per MATLAB session:

   ```matlab
   shareMATLABSession()
   ```

   Tip: you can add it to your `startup.m` so it's always on.

## 3.3 Tell your agent about the server

This is the only step that differs per agent.

### Claude Code

In a terminal, from any folder (use *your* path to the binary):

```bash
claude mcp add --scope user --transport stdio matlab -- C:\tools\matlab-mcp-core-server-win64.exe
```

(`--scope user` makes it available in every project, not just the current
folder.) Restart Claude Code afterwards. `/mcp` inside Claude Code should list
`matlab` as connected.

### VS Code / GitHub Copilot

1. `Ctrl+Shift+P` → **"MCP: Open User Configuration"** (opens `mcp.json`).
2. Add the server (use *your* path; note doubled backslashes on Windows):

   ```json
   {
       "servers": {
           "matlab": {
               "type": "stdio",
               "command": "C:\\tools\\matlab-mcp-core-server-win64.exe",
               "args": []
           }
       }
   }
   ```

3. Save. A "Start" link appears above the server entry — click it (or
   `Ctrl+Shift+P` → "MCP: List Servers" → matlab → Start).
4. In Copilot Chat (Agent mode), click the 🛠️ tools icon and confirm the
   MATLAB tools are listed and enabled.

### Antigravity

1. In the agent panel, open the settings/“⋯” menu → **MCP Servers** →
   **Manage MCP servers** → **View raw config** (this edits
   `mcp_config.json`).
2. Add the same kind of entry:

   ```json
   {
       "mcpServers": {
           "matlab": {
               "command": "C:\\tools\\matlab-mcp-core-server-win64.exe",
               "args": []
           }
       }
   }
   ```

3. Save and click refresh in the MCP servers list; `matlab` should show its
   tools.

## 3.4 Verify the whole chain 🎉

1. Open MATLAB and run `shareMATLABSession()` (if you did step 3.2).
2. Open this repo in your IDE, open the agent chat, and ask:

   > Using the MATLAB tools, tell me which MATLAB version and toolboxes I
   > have installed.

   The agent should call a tool named something like
   `detect_matlab_toolboxes` and report real versions. (The first call may be
   slow if it has to start MATLAB.)
3. Then ask:

   > In MATLAB, plot a sine wave with a title that says "hello from my agent".

   A figure window should appear in your MATLAB desktop.

If either fails, see [troubleshooting](troubleshooting.md).

✅ **Checkpoint:** the agent can run MATLAB code and you can see the figure.
Setup is done — go to [module 0](../modules/module-0-hello-agent/README.md),
or read the [prompting guide](04-prompting-guide.md) first.
