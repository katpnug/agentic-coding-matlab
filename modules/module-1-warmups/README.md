# Module 1 — Warm-ups: small, targeted asks

**Goal:** practice the core habits — small steps, constrained edits, reading
the agent's output — on four tiny self-contained scripts.
**Time:** ~30–45 minutes.
**Files:** four `warmup*.m` scripts in this folder. Each is deliberately
broken or bad in a different way.

A note before you start: the *point* is not the fixed scripts (the
[solutions](../../solutions/module1/) already exist). The point is practicing
how to direct an agent precisely and check what it did.

## 1.1 Fix the error — `warmup1_fix_the_error.m`

The script crashes. Prompt:

> Run `modules/module-1-warmups/warmup1_fix_the_error.m` with the MATLAB
> tools. Read the error, fix it, and run it again. Keep fixing until it runs.
> Change as little as possible and tell me each change you made.

**Things to notice:** there are *two* bugs — fixing the first reveals the
second. Watch the agent iterate. Afterwards ask: *"explain both bugs as if to
a new student"*. (The second bug — bar/edges length mismatch — is one every
MATLAB user hits eventually. `histcounts` returns one fewer count than
edges.)

## 1.2 Decode cryptic code — `warmup2_cryptic_code.m`

The script works but is unreadable (single-letter variables, no comments).
Two-stage prompt. First, *understanding only*:

> Read `warmup2_cryptic_code.m` and tell me, in plain English, what it does —
> what kind of data it simulates and what the figure and the printed numbers
> mean. Don't change anything yet.

Check its story (it simulates a spike train and computes a firing-rate trace
and the inter-spike-interval distribution). Then, *the constrained edit*:

> Now rewrite it for readability: meaningful variable names, comments, `%%`
> sections, and named constants instead of magic numbers like 0.001. The
> printed numbers must be IDENTICAL before and after. Run both versions to
> prove it.

**Things to notice:** the last sentence gives the agent a *verifiable test*.
Asking for proof beats hoping.

## 1.3 Rescue the figure — `warmup3_ugly_figure.m`

The analysis is fine; the figure is dreadful. Prompt — and make your own
choices here, you're the one with taste:

> Run `warmup3_ugly_figure.m`. Improve the figure: axis labels with units,
> a legend naming each neuron's preferred direction, larger fonts, x-ticks
> every 90°, and save it as a 300 dpi PNG into `outputs/`. Don't change the
> simulated data or the rng seed.

**Things to notice:** specific requests ("x-ticks every 90°") get specific
results. "Make it nicer" gets generic results. Iterate — it's a
conversation, not a single shot.

## 1.4 Speed up the slow script — `warmup4_slow_loop.m`

> Run `warmup4_slow_loop.m` and note the elapsed time. Explain why it's
> slow, then make it faster without changing the printed grand mean. Report
> before/after timings.

**Things to notice:** the agent should mention array growth without
preallocation and replacing the inner loop with vectorized indexing — and the
grand mean must match exactly. If it changes, the "optimization" changed the
analysis: reject it. (This matters for science: performance edits must be
behavior-preserving, and you just learned how to demand proof.)

## ✅ Done when

All four scripts run clean and you've compared your results with
[solutions/module1](../../solutions/module1/). Next:
[Module 2 — your first analysis from scratch](../module-2-toy-analysis/README.md).
