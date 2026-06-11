# Module 2 — A toy analysis from a blank file

**Goal:** drive a complete mini-analysis — simulate data, fit a model, plot,
interpret — purely by prompting. No starter code: you start from nothing.
**Time:** ~30–45 minutes.

The scenario: a (made-up) motor cortex neuron whose firing rate depends
linearly on reach speed, and we want to recover that relationship with a
regression — the simplest version of what you'll do with real data in
modules 3–4.

Work *one prompt at a time*. Check each result before the next step.

## 2.1 Simulate

> Create a new script `modules/module-2-toy-analysis/speed_tuning.m`. In it,
> simulate 100 reaching trials: reach speed drawn uniformly between 5 and
> 50 cm/s, and a neuron whose firing rate is 8 Hz baseline + 0.6 Hz per cm/s
> of speed, plus Gaussian noise with SD 4 Hz. Use a fixed rng seed. Run it
> and report the mean firing rate.

Sanity-check: baseline 8 + 0.6×(mean speed ≈ 27.5) ≈ 24.5 Hz. Does the
reported mean make sense? (Habit: *predict* the number before you read it.)

## 2.2 Look at it

> Add a scatter plot of firing rate vs reach speed, labeled with units.

Always look at raw data before fitting. Ask yourself: does it look linear?
Would you spot it if you'd accidentally simulated speed in m/s?

## 2.3 Fit

> Fit a linear regression of firing rate on speed using polyfit (base
> MATLAB only). Overlay the fit line on the scatter, report slope and
> intercept with units, and compare them to the true values we simulated.

The fitted slope should land near 0.6 Hz/(cm/s) and intercept near 8 Hz —
*you know the ground truth because you simulated it*. This is the cheapest
habit in computational science: test the pipeline on data where you know the
answer, **before** touching real data.

## 2.4 Break it on purpose (the best part)

> Re-run the simulation with noise SD 20 instead of 4, and with only 15
> trials instead of 100. Refit and show me how the slope estimate changes.
> Then put it back.

You just did a power analysis by conversation. Worth internalizing: asking
"how would this fail?" costs one sentence.

## 2.5 Stretch goals (optional)

- "Wrap the simulate-and-fit in a loop over 1000 repeats and histogram the
  fitted slopes" — a bootstrap intuition-builder.
- "Make the tuning quadratic instead of linear in the simulation, but keep
  fitting a line. What does the fit residual plot look like?" — model
  misspecification, visible.

## ✅ Done when

Your `speed_tuning.m` runs end-to-end, the recovered slope ≈ 0.6, and you can
explain every line (ask the agent to walk you through any you can't). Compare
with [solutions/module2](../../solutions/module2/). Next:
[Module 3 — real behavior data](../module-3-behavior/README.md).
