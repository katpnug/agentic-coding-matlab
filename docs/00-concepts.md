# 0. What is agentic coding? (read this first)

*Time: ~10 minutes of reading. No computer needed.*

## The 30-second version

An **AI coding agent** is a program that can read your files, write code, run
it, look at the result, and try again — in a loop — based on instructions you
give it in plain English. Your job shifts from *writing every line of code* to
*describing what you want, checking the agent's work, and steering it*.

For us, that means you can say:

> "Load `reach_subset.mat`, and plot a raster of unit 3's spikes aligned to
> each reach onset, sorted by reach duration."

…and watch the agent write the MATLAB, run it, see the error it made, fix it,
and show you the figure.

## Words you will hear (plain-English glossary)

| Term | What it actually means |
|---|---|
| **LLM** (large language model) | The underlying AI (e.g. Claude, GPT, Gemini) that predicts text. On its own it can only *talk*. |
| **Agent** | An LLM wired up with *tools* — read a file, edit a file, run a command — so it can *act*, not just talk. It works in a loop: think → act → look at result → repeat. |
| **Prompt** | The instruction you type. Better prompts (more context, clearer goals) give better results. See the [prompting guide](04-prompting-guide.md). |
| **Context / context window** | Everything the agent currently "has in mind": your conversation, files it has read, outputs it has seen. It is finite — agents forget what was never put in front of them. |
| **MCP** (Model Context Protocol) | A standard plug for giving agents new tools. The **MATLAB MCP server** is a plug that lets any MCP-capable agent run MATLAB code in a real MATLAB session on your machine. |
| **IDE** | The editor you work in (VS Code, Antigravity). The agent lives inside it as a chat panel. |
| **`AGENTS.md`** | A text file in your project that the agent reads automatically — your standing instructions ("our data lives here", "we plot in this style"). Covered in module 5. |
| **Skill / subagent** | Reusable packaged instructions (a skill) and specialized helper agents (subagents). Also module 5. |

## Why MCP + MATLAB instead of copy-pasting into a chatbot?

You may have pasted code into ChatGPT or Claude in a browser. That works, but
the chatbot can't *see your data* or *run anything* — you become the
copy-paste middleman, and errors bounce back and forth through you.

With the MATLAB MCP server, the agent:

1. **Runs code in your actual MATLAB**, with your toolboxes, your paths, your
   data on disk.
2. **Sees the real error messages and outputs** and fixes its own mistakes.
3. **Leaves the figures in your MATLAB desktop**, where you can zoom, edit,
   and export like always.

## The mindset (the most important section)

Agents are powerful and confidently wrong. Three habits make the difference
between "this is magic" and "this wasted my afternoon":

1. **Small steps.** Ask for one thing at a time ("load the file and tell me
   what's in it"), not a whole analysis in one prompt. Small steps are easy to
   check; a 200-line wall of generated code is not.
2. **Read the diff / read the output.** When the agent edits a file or shows a
   result, actually look. You are the reviewer. If a number looks off (a
   firing rate of 6,000 Hz, a reach lasting 90 s), say so — the agent will
   re-examine.
3. **You own the science.** The agent knows MATLAB syntax very well and your
   experiment not at all. It will happily compute a beautiful PSTH aligned to
   the wrong event. The domain checks — units, alignment, what's biologically
   plausible — are yours.

## What can go wrong (so it doesn't surprise you)

- **Hallucinated functions/fields** — the agent may call `data.reachOnsets`
  when no such field exists. It usually self-corrects after the error; you can
  prevent it by telling it the real field names (or pointing it to
  `example_data/README.md`).
- **Plausible-but-wrong analysis** — runs without error, means nothing. Caught
  only by habit #3 above.
- **Doing too much** — agents sometimes "helpfully" refactor things you didn't
  ask about. Ask for small steps and say "change nothing else".

Next: [1. Set up your IDE](01-setup-ide.md)
