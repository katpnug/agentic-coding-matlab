# Module 4 — Capstone: event-aligned spikes

**Goal:** the real thing. Align Neuropixels spike trains to reach onsets and
build the two workhorse figures of systems neuroscience — the **raster** and
the **PSTH** — then compare successful vs other reaches across all 10 units.
**Time:** ~60–90 minutes.
**Data:** `example_data/reach_subset.mat` (`cellData` = 10 sorted units;
`ReachS` = 159 reaches; same clock, seconds). Dictionary:
[example_data/README.md](../../example_data/README.md).

By now you know the drill: one step, check, next step. This module gives you
fewer literal prompts and more *goals* — write the prompts yourself, you've
had three modules of practice.

## 4.0 A trap on purpose: vague prompts make plausible wrong figures

Before the careful version, try one intentionally underspecified prompt:

> Plot spikes around reaches for unit 3.

Let the agent produce code or a figure. Do not fix the prompt yet.

Now audit the result:

- What did it use as reach onset times?
- Did it skip `exclude == 1` reaches?
- Did it handle empty `out` fields?
- Is the spike window in seconds, not samples?
- Is the PSTH normalized by both event count and bin width?
- Is the mean firing rate plausible for `cellData(3).fr`?
- Does the figure label units clearly?

Most agents will still produce something that looks finished. That is the
lesson: a clean figure is not evidence that the analysis is correct.

Now replace the vague prompt with the specific prompt in 4.1 and compare the
new result to the first one. What changed?

## 4.1 Define the events

> Create `modules/module-4-spikes/reach_psth.m`. Load
> `example_data/reach_subset.mat`. Build a vector of reach onset times:
> for each ReachS element take `out(1,1)` (first sample of the outward
> movement); fall back to the window center `filtered(301,1)` if `out` is
> empty; skip reaches with `exclude == 1`. Also keep a logical vector of
> which reaches have `sucfail == 1`. Report how many events of each kind.

Expect ~150 usable reaches, 44 successful. **Verify before proceeding** —
every downstream figure depends on these event times.

## 4.2 One unit, one raster

> Add a spike raster for unit 3 (`cellData(3).spike_times`): a window of
> −2 to +3 s around each reach onset, one row per reach, a tick per spike,
> and a vertical line at 0.

Sanity checks: unit 3 fires ~100 Hz × 5 s window → roughly 500 ticks per
row. Empty raster or a solid black wall means a units/alignment bug (seconds
vs samples, wrong clock). You know the firing rate from `cellData(3).fr` —
use it.

## 4.3 The PSTH

> Below the raster, add the PSTH: spike counts in 50 ms bins averaged over
> reaches, converted to firing rate in Hz (counts / n_events / bin_width),
> smoothed lightly. Share the x-axis with the raster.

Classic gotcha the agent may make for you: forgetting to divide by bin width
*and* event count, giving "rates" of 0.4 Hz or 4000 Hz for a 100 Hz neuron.
Now you catch it on sight.

## 4.4 Success vs the rest

> Split the PSTH into successful reaches vs the rest, plotted in two colors
> with a shaded SEM band, with group sizes in the legend.

## 4.5 The grid: all 10 units

> Make a 2×5 tiled figure showing the success-vs-rest PSTH for every unit,
> titled with cluster ID, depth, and quality from cellData. Save it as a
> 300 dpi PNG in `outputs/`.

Look at the result like a scientist: which units modulate at reach onset?
Before it? Do any *pause*? Does success matter? Pick the most interesting
unit and dig in.

## 4.6 The negative control (do not skip this)

The habit that separates analysis from wishful thinking:

> Repeat the unit-3 PSTH but with reach onset times circularly shifted by a
> random offset (or shuffled within the session). The event-locked structure
> should disappear. Show both side by side.

If "alignment" survives shuffled event times, you're aligned to something
trivial (or to nothing). Cheap to ask for; priceless to have.

## 4.7 Stretch goals

- Sort the raster rows by reach peak speed (compute it from `filtered`
  columns 2–4) — does latency track vigor?
- Recompute the binned firing-rate matrices (`Bin10`) that were stripped from
  the subset, straight from `spike_times`.
- Regression across units: reach-onset modulation depth vs probe `depth` —
  a real version of module 2's toy.

## ✅ Done when

You have the 10-unit grid figure, your shuffle control is flat, and
`reach_psth.m` reruns end-to-end from a fresh MATLAB session. Compare with
[solutions/module4](../../solutions/module4/). Last stop:
[Module 5 — make it stick with skills & agents](../module-5-skills-and-agents/README.md).
