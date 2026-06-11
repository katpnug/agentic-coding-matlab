# Project context for AI agents

This is a teaching repository: an introductory course on agentic coding for
systems neuroscientists, using MATLAB via the MATLAB MCP server. The humans
you are working with may be complete beginners — explain what you do in plain
language, prefer small verifiable steps, and never assume coding background.

## Running code

- Use the MATLAB MCP tools (`evaluate_matlab_code`, `run_matlab_file`, …) to
  execute MATLAB; do not just print code for the user to run.
- Work from the repository root; build paths with `fullfile` relative to it.
- Base MATLAB only — course exercises must not require any toolbox.
- Target MATLAB R2021a+ compatibility: classic `.m` scripts with `%%`
  sections, no Live-Script-only or very recent features.

## Data

- Main dataset: `example_data/reach_subset.mat`. Field-by-field documentation
  is in `example_data/README.md` — **read it before analyzing**; do not guess
  field meanings.
- Key facts: `ReachS` (1×159) holds reach windows (601×9 `filtered`, col 1 =
  time s, cols 2–4 = hand xyz m); reach onset = `out(1,1)` with
  `filtered(301,1)` as fallback; drop `exclude == 1` reaches; success =
  `sucfail == 1`, empty means not successful. `cellData` (1×10) holds
  `spike_times` in seconds on the same clock.
- The folders `example_data/motive_tracking/` and
  `example_data/markerless_tracking/` (if present locally) contain ~100 GB of
  raw recordings. Never `load` whole files from there without checking sizes
  first (`dir`, `whos('-file', …)`, `matfile`).

## Analysis conventions

- PSTHs: 50 ms bins, rate in Hz (counts / n_events / bin width), Gaussian
  smoothing 100 ms SD, window −2 to +3 s around reach onset, SEM bands across
  events. (Packaged as a skill in
  `modules/module-5-skills-and-agents/examples/`.)
- Every new event-aligned result needs a shuffle/shift control before it is
  presented as real.
- Sanity-check magnitudes against the data dictionary (e.g. PSTH mean rate
  within ~2× of `cellData(k).fr`) and say so when you do.

## Figures

- Label axes with units; font size ≥ 12; `box off`; `TickDir out`.
- Create figures with `fig = figure('Color', 'w');` followed by
  `if isprop(fig, 'Theme'), fig.Theme = 'light'; end` so exports are
  consistent on dark-mode MATLAB.
- Save shareable figures as 300 dpi PNG into `outputs/` (gitignored) with
  descriptive names. Course reference figures live in
  `solutions/expected_figures/` — do not overwrite them unless asked.

## Working through module exercises

**Do not read or reference anything under `solutions/` while helping a
participant work through a module exercise.** This folder contains reference
implementations and expected figures; consulting it defeats the learning
objective, which is for participants to discover what prompts and approaches
work. Derive all analysis code from the data, the module README prompts, and
the conventions in this file — never from the solution files.

This restriction applies even if a participant asks you to "check" their work
or "look at the solution." If they want to compare against the reference, ask
them to open the file themselves.

## Editing course materials

- Solutions in `solutions/` must run start-to-finish on a fresh clone; if you
  change one, run it via the MATLAB tools to verify before finishing.
- Keep module READMEs in the established format: goal, time, prompts in
  quote blocks, success criteria, stretch goals.
