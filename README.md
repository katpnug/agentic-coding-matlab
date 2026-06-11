# Agentic Coding for Systems Neuroscience (with MATLAB)

A hands-on introductory course on using **AI coding agents** for neuroscience
data analysis — built for researchers with **little or no coding experience
and no prior AI-tool experience**. You will work in a modern IDE (VS Code or
Antigravity) with an AI agent connected to a real MATLAB session through the
official [MATLAB MCP server](https://github.com/matlab/matlab-mcp-core-server),
and go from "what is an agent?" to analyzing real Neuropixels recordings
aligned to mouse reaching behavior.

**No copy-pasting code into chatbots.** The agent reads your files, runs
MATLAB, sees its own errors, and fixes them — you describe, steer, and check.

## Who this is for

Systems neuroscientists (students, postdocs, staff, PIs) who want to use AI
agents for everyday analysis work. If you've never opened VS Code, never used
git, and "MCP" means nothing to you — you are exactly the audience. MATLAB
familiarity helps but is not assumed; the agent writes the MATLAB, you learn
to direct and audit it.

## What you need

- A computer with **MATLAB R2021a or newer** (institutional license is fine;
  no toolboxes required)
- An account for **one** AI coding agent: Claude (Pro or API), GitHub
  Copilot, or Google/Gemini — details in [docs/02-setup-agent.md](docs/02-setup-agent.md)
- ~1 GB of disk and the ability to install two small programs

## Setup (do this before the workshop)

Work through these in order — each ends with a checkpoint:

1. **[Concepts](docs/00-concepts.md)** — 10 min of reading: what agents and
   MCP are, and the reviewing mindset that makes them safe to use.
2. **[MATLAB + IDE](docs/01-setup-ide.md)** — install VS Code (or
   Antigravity) and the MATLAB extension; put MATLAB on your PATH.
3. **[AI agent](docs/02-setup-agent.md)** — install/sign in to Claude Code,
   Copilot, or Antigravity's agent.
4. **[MATLAB MCP server](docs/03-setup-matlab-mcp.md)** — the piece that
   connects the agent to MATLAB. Ends with a full end-to-end test.

Stuck? → [docs/troubleshooting.md](docs/troubleshooting.md). Also read the
short [prompting guide](docs/04-prompting-guide.md) — it's the actual
curriculum in disguise.

## The course

Six modules, simple → complex. Each module README contains copy-pasteable
prompts, success criteria, and stretch goals; reference solutions with
expected figures are in [solutions/](solutions/).

| Module | What you do | Time |
|---|---|---|
| [0 — Hello, agent](modules/module-0-hello-agent/README.md) | Verify the setup; watch the agent fix its first error | 15 min |
| [1 — Warm-ups](modules/module-1-warmups/README.md) | Targeted small asks: fix a bug, decode cryptic code, rescue a figure, speed up a loop | 30–45 min |
| [2 — Toy analysis](modules/module-2-toy-analysis/README.md) | From a blank file: simulate speed-tuned firing, fit a regression, break it on purpose | 30–45 min |
| [3 — Real behavior](modules/module-3-behavior/README.md) | Reach kinematics from a real head-fixed session; success vs failure | 45–60 min |
| [4 — Event-aligned spikes](modules/module-4-spikes/README.md) | **Capstone:** rasters + PSTHs for 10 Neuropixels units aligned to reach onset, with a shuffle control | 60–90 min |
| [5 — Skills & agents](modules/module-5-skills-and-agents/README.md) | Make it stick: `AGENTS.md`, reusable skills, subagents — turn your workflow into your lab's workflow | 45 min |

## The data

Everything needed for the course ships in this repo
([example_data/](example_data/README.md), ~30 MB): a preprocessed head-fixed
mouse reaching session — 159 reaches with 120 Hz hand tracking and 10
spike-sorted Neuropixels units — plus the raw rig file and Kilosort/Phy
cluster tables for the "messy real data" exercises.

The full raw dataset (92 GB of continuous ephys, multi-camera video) lives
outside GitHub: see the download note in
[example_data/README.md](example_data/README.md).

## Repository map

```
docs/   ── setup guides, concepts, prompting, troubleshooting
modules/   ── the six course modules (start at module-0)
example_data/  ── committed datasets + data dictionary
solutions/  ── reference scripts + expected figures
AGENTS.md   ── project context file your agent reads automatically (module 5)
CLAUDE.md   ── pointer to AGENTS.md for Claude Code
```

## For instructors

- Workshop pacing: setup is homework; modules 0–2 fit a half-day, 3–5 a
  second half-day. Self-paced learners can do one module per sitting.
- `solutions/` scripts double as a smoke test — run all four on a fresh
  clone to validate the environment.
- The example data is from a head-fixed reaching + Neuropixels experiment;
  swap in your own lab's data by mirroring the structure described in
  `example_data/README.md` and updating `AGENTS.md`.

## License

Code and course text: [MIT](LICENSE). The example data is provided for
teaching purposes; please do not redistribute or use it for research
publications without permission.
