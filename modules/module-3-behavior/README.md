# Module 3 — Real behavior: reach kinematics

**Goal:** work with *real* preprocessed lab data — explore an unfamiliar
`.mat` file, plot reach trajectories, and compare successful vs other
reaches.
**Time:** ~45–60 minutes.
**Data:** `example_data/reach_subset.mat` — a head-fixed mouse reaching
session (159 reaches, 120 Hz hand tracking). Full data dictionary:
[example_data/README.md](../../example_data/README.md).

## 3.1 Meet the data (no analysis yet)

Real data first contact should always be reconnaissance:

> Load `example_data/reach_subset.mat` with the MATLAB tools and describe
> every variable: sizes, types, and what you think each one is. Read
> `example_data/README.md` to check your guesses. Don't analyze anything yet.

**Things to notice:** the agent can read the data dictionary file itself —
you don't have to retype it. This is "giving context" at almost zero cost.

## 3.2 One reach

> From ReachS, take reach 12. Its `filtered` field is a 601×9 matrix:
> column 1 is time in seconds, columns 2–4 are hand x, y, z position in
> meters. Make a figure with (top) the 3-D trajectory using plot3, and
> (bottom) x, y, z each against time. Mark the reach onset — the first row
> of the `out` field — with a vertical line. If `out` is empty for that
> reach, use the window center, `filtered(301, 1)`, instead.

(That last sentence is there because reach 12's `out` *is* empty — real
data bites. If you omit it, watch how your agent discovers and handles the
problem on its own.)

Sanity checks to run by eye: the window should span ~5 s; positions should be
a few centimeters in range; the onset line should sit roughly mid-window,
where the position traces start moving.

## 3.3 All reaches, aligned

> Now overlay all 159 reaches: for each ReachS element, plot the x-position
> (column 2 of `filtered`) against time relative to the window center
> (sample 301 of 601). Skip reaches where `exclude` is 1. Use thin gray
> lines, plus the mean across reaches as a thick black line.

**Things to notice:** "time relative to window center" is an *alignment* —
the same operation you'll do with spikes in module 4. If the agent's mean
trace looks wrong, the usual suspect is mixing up absolute session time vs
within-window time. Catch it here, where you can see it.

## 3.4 Success vs the rest

The `sucfail` field is `1` for the 44 reaches scored as successful and empty
otherwise:

> Split the reaches into successful (`sucfail == 1`) and the rest (treat
> empty as not-successful), excluding `exclude == 1` reaches. Plot the mean
> aligned x-position trace for each group in different colors with a legend
> showing group sizes. Do the trajectories differ?

Interpretation is yours, not the agent's: do successful reaches look
faster? Smoother? Earlier? Ask the agent for follow-up quantification —
e.g. *"compute peak speed per reach from columns 2–4 and compare the two
groups with a boxchart"* — but **you** decide what's worth quantifying.

## 3.5 Stretch: the messy raw file

`example_data/20250612_hFix007.mat` is the *raw* file the rig saved —
undocumented globals, leftover GUI handles, the lot. Pure archaeology:

> Load `example_data/20250612_hFix007.mat` and figure out what's in it.
> Which variables look like data and which look like leftover program state?
> Cross-reference with reach_subset.mat: can you find the raw event times
> (`r_act_time`, `suc`) that the 159 ReachS reaches were built from?

This is the single most realistic exercise in the course. Every lab has
files like this.

## ✅ Done when

You have the aligned-overlay and success-vs-rest figures and can say in one
sentence what each shows. Compare with
[solutions/module3](../../solutions/module3/). Next:
[Module 4 — event-aligned spikes](../module-4-spikes/README.md).
