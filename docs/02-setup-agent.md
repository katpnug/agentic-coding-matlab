# 2. Set up an AI coding agent

*Time: 10–20 minutes. You need ONE of the options below.*

This course is **agent-agnostic**: every exercise is written as plain-English
prompts that work with any modern coding agent that supports MCP. Pick one:

| Agent | Runs in | Account needed | Notes |
|---|---|---|---|
| **Claude Code** | VS Code (extension) or any terminal | Claude Pro/Max, or Anthropic API key | Richest support for the module-5 material (skills, subagents, `CLAUDE.md`). |
| **GitHub Copilot (agent mode)** | VS Code | GitHub account w/ Copilot (free tier exists; often free for academics) | Easiest if you already live in GitHub. |
| **Antigravity (Gemini)** | Antigravity IDE | Google account | Agent is built into the IDE — nothing extra to install. |

If you have no constraints and want the closest match to the course material,
use **Claude Code in VS Code**.

## Option A — Claude Code

1. You need either a **Claude Pro/Max subscription** (sign in at
   <https://claude.ai>) or an **Anthropic API key** (<https://console.anthropic.com>).
2. In VS Code, install the **"Claude Code"** extension (publisher:
   *Anthropic*). Alternatively/additionally, install the CLI — on Windows,
   in PowerShell:

   ```powershell
   irm https://claude.ai/install.ps1 | iex
   ```

   (macOS/Linux: `curl -fsSL https://claude.ai/install.sh | bash`)
3. Open this repository folder in VS Code, open the Claude Code panel (or run
   `claude` in the integrated terminal: `` Ctrl+` ``), and sign in when
   prompted.
4. **Verify:** ask it `What files are in this project?` — it should list the
   repo contents.

## Option B — GitHub Copilot agent mode

1. Sign in to <https://github.com> and enable Copilot
   (<https://github.com/features/copilot> — check for academic/free access).
2. In VS Code, install the **"GitHub Copilot"** and **"GitHub Copilot Chat"**
   extensions and sign in with your GitHub account when prompted.
3. Open the Copilot Chat panel (`Ctrl+Alt+I`) and switch the mode dropdown
   (bottom of the chat box) from "Ask" to **"Agent"**.
4. **Verify:** in Agent mode, ask `What files are in this project?`

## Option C — Antigravity (Gemini)

1. The agent is built in — if you completed the Antigravity install on the
   [previous page](01-setup-ide.md), you're done.
2. Open the agent side panel, make sure you're signed in with your Google
   account.
3. **Verify:** ask `What files are in this project?`

## A note on data privacy

Whichever agent you use, code and file contents it reads are sent to the
provider's servers (Anthropic / GitHub+OpenAI / Google) to generate responses.
The example data in this repo is fine to share. **Before using these tools on
unpublished lab data, check your institution's and lab's policy.** Most
providers offer settings to disable training on your data — turn that on.

✅ **Checkpoint:** your agent answers questions about the files in this repo.
It can *see* your project now — next we let it *run MATLAB*:
[3. Set up the MATLAB MCP server](03-setup-matlab-mcp.md)
