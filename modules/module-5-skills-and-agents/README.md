# Module 5 — Make it stick: context files, skills, and subagents

**Goal:** stop repeating yourself. Everything you typed into prompts in
modules 3–4 ("column 1 is time…", "our PSTHs use 50 ms bins…") can live in
files the agent reads automatically. This is how a *personal* trick becomes a
*lab* workflow.
**Time:** ~45 minutes.

Three mechanisms, in increasing order of specialization:

| Mechanism | What it is | When the agent uses it |
|---|---|---|
| **Context file** (`AGENTS.md` / `CLAUDE.md`) | Standing instructions for a project | Always — loaded at the start of every conversation in that folder |
| **Skill** (`SKILL.md`) | A named, packaged procedure ("how we make PSTHs") | When the task matches the skill's description |
| **Subagent** | A separate specialist agent with its own instructions | When delegated a subtask (explicitly or automatically) |

## 5.1 Context files: `AGENTS.md`

`AGENTS.md` is a plain markdown file at the project root. Most agents
(Claude Code, Copilot, Antigravity, Codex, Cursor…) read it automatically.
Claude Code historically reads `CLAUDE.md` — the convention used in this repo
is an `AGENTS.md` with the content and a one-line `CLAUDE.md` that imports
it. Open both files at this repo's root and read them now; they're short.

**Exercise — see it work.** Start a *fresh* agent conversation and ask:

> Plot a PSTH for unit 5 aligned to reach onsets.

Notice what you did *not* have to say: where the data is, what the fields
mean, how onsets are defined. The agent got all of it from `AGENTS.md` (which
points it at `example_data/README.md`). Compare with how much context module
4 prompts needed.

**Exercise — extend it.** Add a rule of your own:

> Append a "Figure style" section to AGENTS.md: font size at least 12,
> no top/right box, always label axes with units, save PNGs at 300 dpi
> to outputs/.

Start another fresh chat, ask for any plot, and check your rules were
followed. You just changed the behavior of every future conversation —
including your labmates', once this is in git.

## 5.2 Skills: `SKILL.md`

A **skill** is a folder containing a `SKILL.md` file: a name, a description
of *when to use it*, and step-by-step instructions (plus optional scripts or
reference files). Agents that support skills load the right one when the task
matches. Claude Code looks in `.claude/skills/`; the same format is being
adopted by other tools (see [agentskills.io](https://agentskills.io)).

This module ships a worked example:
[`examples/.claude/skills/psth-conventions/SKILL.md`](examples/.claude/skills/psth-conventions/SKILL.md)
— our lab's PSTH recipe (bins, smoothing, baseline, colors, the mandatory
shuffle control from module 4.6).

**Exercise — install and trigger it** (Claude Code):

1. Copy the `examples/.claude/skills/psth-conventions` folder into this
   repo's `.claude/skills/` folder (create it if needed).
2. Fresh conversation: `Make a PSTH for unit 7.`
3. Watch the skill load (Claude announces it) and check the output follows
   the conventions — SEM bands, baseline window, the works — *unprompted*.

**Exercise — write your own.** Pick something your lab does the same way
every time (spike-sorting QC summary? behavior session report?) and:

> Read .claude/skills/psth-conventions/SKILL.md as a template, then
> interview me about how I make [my figure/analysis], and write a new skill
> capturing it.

Having the agent interview *you* is the fastest way to externalize a method
you've never written down.

## 5.3 Subagents

A **subagent** is a named helper with its own instructions and tool
permissions, useful for (a) specialization and (b) keeping exploration mess
out of your main conversation. In Claude Code they live in `.claude/agents/`.

Worked example:
[`examples/.claude/agents/data-explorer.md`](examples/.claude/agents/data-explorer.md)
— a *read-only* data reconnaissance agent: it may load files and report
structure, but its instructions forbid analysis or edits. Exactly what you
want pointed at a 90 GB folder of unknown rig output.

**Exercise** (Claude Code): copy it to `.claude/agents/`, then:

> Use the data-explorer agent to investigate
> example_data/20250612_hFix007.mat and report what's in it.

Note how the main conversation stays clean: you get the report, not the
twenty intermediate `whos` calls.

## 5.4 If you're not on Claude Code

The ideas transfer; the file locations differ:

| Concept | GitHub Copilot | Antigravity |
|---|---|---|
| Context file | `AGENTS.md` (supported) or `.github/copilot-instructions.md` | `AGENTS.md` (supported) |
| Skills | "prompt files" (`.github/prompts/*.prompt.md`), invoked with `/name` | Workflows / rules in the agent settings; skills support is evolving |
| Subagents | — (use chat participants/modes) | Built-in agent manager runs parallel agents |

The durable skill you're learning is *writing instructions down* — the markdown
itself is portable even when the folder names aren't.

## ✅ Done when

A fresh conversation in this repo produces a convention-following PSTH from
the one-line prompt, and you've drafted one skill for something your lab
actually does. **That file is the take-home.** Put it in your own repo
tomorrow.
