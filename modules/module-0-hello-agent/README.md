# Module 0 — Hello, agent

**Goal:** confirm your full setup works (IDE → agent → MCP → MATLAB) and get a
feel for the think→act→check loop.
**Time:** ~15 minutes.
**Prerequisites:** [setup docs 1–3](../../docs/01-setup-ide.md) completed.

## Before you start

1. Open MATLAB and run `shareMATLABSession()` (if you set up shared mode).
2. Open this repository folder in your IDE and open the agent chat.

## Exercise 0.1 — Can it see MATLAB?

Type into the agent chat:

> Using the MATLAB tools, report my MATLAB version and list my installed
> toolboxes.

**Success looks like:** the agent calls a MATLAB tool (you'll see a tool-use
entry in the chat, perhaps asking your permission first — allow it) and
reports versions that match reality. If it answers *without* using a tool, or
says it has no MATLAB access, go to
[troubleshooting](../../docs/troubleshooting.md).

## Exercise 0.2 — Can it run code you can see?

> In MATLAB, create a figure with two subplots: a sine wave on the left and
> a cosine on the right. Title the figure "hello from my agent".

**Success looks like:** a figure window appears in your MATLAB desktop
(shared-session mode). Zoom into it — it's a normal MATLAB figure; the agent
just typed the commands for you.

## Exercise 0.3 — Watch it recover from an error

This is the heart of agentic coding. Ask for something that will fail on the
first try:

> Run this exact MATLAB line and then fix whatever is wrong with it:
> `plot(linspace(0, 10, 100), sin(linspace(0, 10, 99)))`

**Watch what happens:** the agent runs it, gets the "vectors must be the same
length" error, *reads the error*, fixes the code, and re-runs. Nobody
copy-pasted anything. That loop — act, observe, correct — is what makes an
agent different from a chatbot.

## Exercise 0.4 — Make it explain

> Explain what you just fixed and why MATLAB raised that error, as if to
> someone who has never programmed.

Get in the habit of asking *why*. You'll learn MATLAB faster by interrogating
the agent than you ever did from error messages alone.

## ✅ Done when

All four exercises work. Continue to
[Module 1 — Warm-ups](../module-1-warmups/README.md).
