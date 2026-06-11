# Troubleshooting

Work top-down: most problems are one of these.

## "matlab is not recognized" / agent says MATLAB not found

MATLAB isn't on your system PATH.

- **Windows:** Start menu → "Edit the system environment variables" →
  Environment Variables → under *System variables* edit `Path` → New → add
  your MATLAB bin folder, e.g. `C:\Program Files\MATLAB\R2024b\bin` → OK.
  **Close and reopen** all terminals/IDEs (they inherit PATH at launch).
- **macOS/Linux:** add `export PATH="/Applications/MATLAB_R2024b.app/bin:$PATH"`
  (adjust path) to `~/.zshrc` or `~/.bashrc`, then open a new terminal.
- Verify with `matlab -batch "disp(2+2)"` in a *fresh* terminal.

## The MCP server doesn't appear / shows "failed" in the agent

- **Check the path** in your config (`mcp.json`, `claude mcp list`, or
  Antigravity's `mcp_config.json`). The #1 cause is a typo'd path. On Windows
  in JSON, backslashes must be doubled: `C:\\tools\\...exe`.
- Run the binary directly in a terminal — if Windows SmartScreen or macOS
  Gatekeeper blocks it, allow it once (macOS: System Settings → Privacy &
  Security → "Open Anyway"; also `chmod +x` the file).
- Restart the IDE after config changes. For Claude Code, check with `/mcp`.
  For VS Code: `Ctrl+Shift+P` → "MCP: List Servers" → check status/logs.

## First MATLAB tool call hangs or takes forever

If no shared session is found the server may be starting a fresh, headless
MATLAB — that takes 30–60 s, and includes a license check. Either be patient
once, or (much better, R2023a+) use shared-session mode:

1. `matlab-mcp-core-server --setup-matlab` (one time)
2. In your open MATLAB: `shareMATLABSession()` — every session.

Figures only appear on your screen in shared-session mode.

## "shareMATLABSession is not found" in MATLAB

The setup step didn't run. From a terminal:
`<full path to server binary> --setup-matlab`, then restart MATLAB. Requires
R2023a or newer; on older releases skip shared mode.

## Agent runs MATLAB but can't find the data file

The agent's MATLAB session may have a different working directory than your
repo. Easiest fixes:

- In MATLAB: `cd` to the repo folder before working.
- Or prompt with full context: "the data is at
  `D:\...\agentic-coding-matlab\example_data\reach_subset.mat`".
- Or tell the agent: "use absolute paths based on this project's root".

## `load` works but fields are missing (Bin1, Bin10…)

You're using `reach_subset.mat`, which intentionally omits the binned
firing-rate matrices (GitHub size limits — see
[example_data/README.md](../example_data/README.md)). Recompute from
`spike_times`, or get the full file from the lab data share.

## Copilot: no "Agent" option in the chat mode dropdown

Update VS Code and the Copilot extensions (agent mode requires recent
versions), then `Ctrl+Shift+P` → "Developer: Reload Window". Check that your
Copilot plan is active at github.com/settings/copilot.

## Claude Code: "credit balance too low" / login loops

You're authenticated against the API console without credits, or the wrong
account. Run `/login` and choose your Claude subscription account, or add API
credits at console.anthropic.com.

## Everything is connected but answers are nonsense

- Long conversation? Start a fresh chat; re-point it at the repo and
  `AGENTS.md`.
- Check that the agent is actually *running* code (you'll see tool calls) and
  not just *imagining* outputs. Ask: "run it via the MATLAB tools and show me
  the actual output".

## Still stuck

Ask your agent! Seriously: paste the error and ask "diagnose this MCP/MATLAB
setup problem step by step". Agents are good at their own plumbing. Otherwise,
file an issue on this repo or grab an instructor during the workshop.
