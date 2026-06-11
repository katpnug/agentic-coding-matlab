# 4. How to talk to a coding agent

*Time: ~10 minutes of reading. Refer back to this throughout the course.*

There is no magic syntax — you write plain English. But some habits reliably
produce better results. Each module practices these; here they are in one
place.

## The five habits

### 1. One step at a time

Bad (one giant prompt):

> Load the data, find all the successful reaches, compute PSTHs for every
> neuron, cluster them, and make a publication figure.

Good (a conversation):

> Load `example_data/reach_subset.mat` and summarize what variables it
> contains.

…then, after checking the answer:

> Great. Extract the onset time of each reach (use `out(1,1)` from each
> ReachS element) and the success label. How many successful reaches are
> there?

Each small step gives you a chance to catch a wrong turn before it compounds.

### 2. Give context instead of hoping

The agent doesn't know your conventions or your data until you tell it (or it
reads a file that says so). Compare:

> Plot the spikes around reaches.

versus:

> In `reach_subset.mat`, `cellData(3).spike_times` is spike times in seconds
> and each `ReachS(i).out(1,1)` is a reach onset in the same clock. Plot a
> spike raster for unit 3 from −2 to +2 s around each reach onset, one row
> per reach.

The second prompt removes all the guessing. Pointing the agent at
`example_data/README.md` ("read example_data/README.md first") works too —
and in module 5 you'll learn to put standing context in `AGENTS.md` so you
never have to repeat it.

### 3. Constrain the blast radius

Agents like to be helpful and may rewrite things you didn't ask about. Say
what *not* to touch:

> Fix the error on line 12 of `warmup1_fix_the_error.m`. Don't change
> anything else in the file.

And prefer "edit this file" over "rewrite this file" — small diffs are
reviewable diffs.

### 4. Make it show its work

After any analysis step, ask for verification you can judge:

> How many spikes ended up in the raster? What's the mean firing rate in the
> baseline window? Does that match `cellData(3).fr`?

Sanity-check numbers against biology: firing rates of 1–100 Hz are plausible;
0.001 Hz or 5 kHz mean something is misaligned (often seconds vs samples vs
milliseconds).

### 5. Paste errors verbatim, don't paraphrase

When something breaks (in MATLAB or anywhere), copy the *entire* red error
text into the chat. The agent is extremely good at reading stack traces. With
the MCP server connected it sees errors itself, but for anything it didn't
run, paste, don't describe.

## Useful prompt patterns (copy/adapt these)

| You want | Try |
|---|---|
| Understand unfamiliar data | "Load `<file>` and describe every variable: size, type, plausible meaning. Don't analyze yet." |
| Understand unfamiliar code | "Explain `<file>` section by section, in plain English, for someone who doesn't code." |
| A plan before action | "Before writing code: propose a plan in bullet points and wait for my OK." |
| A figure improved | "Make this figure publication-quality: label axes with units, larger fonts, no box, export 300 dpi PNG to `outputs/`." |
| Carefulness | "If anything about the data doesn't match my description, stop and tell me instead of guessing." |
| To learn, not just get answers | "Do it, then walk me through the code you wrote line by line." |

## When the agent goes wrong

- **It's stuck in a fix-error-fix loop** → interrupt; restate the goal; give
  it a hint or simplify the step.
- **It invented a field/function** → tell it the truth ("there is no
  `reach_onsets` variable; onsets are `ReachS(i).out(1,1)`").
- **The conversation is long and it's getting confused** → start a fresh chat
  and re-establish context (this is where `AGENTS.md` shines).
- **The result runs but you don't trust it** → ask it to test itself: "write
  a quick check that the alignment is right, e.g. shuffle the onset times and
  show the PSTH structure disappears."

That last one is real science, by the way — agents make negative controls
cheap. Use that.
