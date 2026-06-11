---
name: psth-conventions
description: Lab conventions for making peri-event time histograms (PSTHs) and spike rasters from this project's reach data. Use whenever asked to plot a PSTH, raster, or event-aligned firing rate.
---

# Lab PSTH conventions

Follow these conventions for every PSTH/raster in this project unless the
user explicitly overrides them.

## Data and alignment

- Data file: `example_data/reach_subset.mat` (field meanings in
  `example_data/README.md`).
- Event times = reach onsets: `ReachS(i).out(1,1)`; if `out` is empty use the
  window center `ReachS(i).filtered(301,1)`. Always drop reaches with
  `exclude == 1`.
- Spike times: `cellData(k).spike_times`, seconds, same clock as ReachS.
- Default window: −2 to +3 s around onset.

## PSTH parameters

- Bin width 50 ms; report it in the y-axis label or caption.
- Units: firing rate in Hz = counts / n_events / bin_width.
- Smoothing: Gaussian, 100 ms SD, applied to the binned rate (note it in the
  caption). Never smooth the raster.
- Always show variability: SEM band across events (mean ± SEM, shaded).
- Baseline: −2 to −1 s before onset. When comparing conditions, also report
  baseline rates.

## Figure style

- Raster on top, PSTH below, shared x-axis; vertical line at t = 0 labeled
  "reach onset".
- Successful reaches (`sucfail == 1`) in MATLAB blue `[0 0.4470 0.7410]`,
  others in gray `[0.5 0.5 0.5]`; group sizes in the legend.
- Axis labels with units; font size ≥ 12; `box off`.
- Title with unit identity: cluster ID, depth, quality (from `cellData`).
- Save figures as 300 dpi PNG into `outputs/` with a descriptive filename
  (e.g. `psth_unit3_cluster181.png`).

## Quality control (mandatory)

After producing any new event-aligned analysis, run a shuffle control:
recompute the PSTH with event times circularly shifted by a random offset
within the session, and confirm the event-locked structure disappears. Show
or report the comparison. If structure survives shuffling, warn the user
loudly instead of presenting the result.

## Sanity checks before presenting results

- Mean rate in the PSTH should be within ~2× of `cellData(k).fr`.
- n_events should be ~150 (or 44 if successful-only); if not, re-check the
  exclusion logic.
