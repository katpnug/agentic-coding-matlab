# Module 2 — A toy analysis from a blank file

**Goal:** drive a complete mini-analysis — simulate data, fit a model, plot,
interpret — purely by prompting. No starter code: you start from nothing.
**Time:** ~30–45 minutes.

The scenario: a (made-up) cerebellar Purkinje cell with a brief reach-aligned
pause in firing. Faster reaches have deeper pauses — a simplified version of
the inverse velocity-tuning identified in Purkinje cells during mouse reaching,
inspired by work from Abigail Person, Dylan Calame, and Matt Becker. Purkinje
cells have high tonic firing rates (~50–100 Hz), so the neuron starts fast and
briefly slows down during the reach. We want to estimate pause magnitude and
recover its relationship with peak reach velocity — the simplest version of
what you'll do with real data in modules 3–4.

Work *one prompt at a time*. Check each result before the next step.

## 2.1 Simulate

> Create a new script `modules/module-2-toy-analysis/speed_tuning.m`. In it,
> simulate 100 reaching trials. For each trial, draw peak reach velocity
> uniformly between 5 and 50 cm/s. Make a time vector from −1 to +1.5 s around
> reach onset. Simulate a bell-shaped velocity trace for each reach, and a
> Purkinje cell firing-rate trace with a 70 Hz baseline and a reach-aligned
> pause whose true depth is `2 + 0.28 * peak_velocity_cm_s` Hz, plus Gaussian
> noise with SD 3 Hz. Use a fixed rng seed. Run it and report the mean true
> pause depth.

Sanity-check: `2 + 0.28×(mean peak velocity ≈ 27.5) ≈ 9.7 Hz`. Does the
reported mean true pause depth make sense? (Habit: *predict* the number before
you read it.)

## 2.2 Look at it

> Plot the simulated velocity traces and firing-rate traces. To make the plot
> readable, split trials into five peak-velocity groups and plot the average
> trace for each group. Label axes with units.

Always look at traces before fitting. Ask yourself: do faster reaches have
larger velocity peaks? Do they also show deeper Purkinje cell pauses?

## 2.3 Estimate pause magnitude

> For each trial, estimate baseline firing rate from the pre-reach window
> −1 to −0.3 s. Then estimate pause magnitude as baseline firing rate minus
> the mean firing rate in the pause window from 0.25 to 0.45 s after reach
> onset. Report the mean estimated pause magnitude.

This is deliberately simple: one baseline window, one post-onset pause window,
one pause number per reach. Later modules use the same idea on real spikes,
where every choice needs more care.

## 2.4 Fit

> Fit a linear regression of estimated pause magnitude on peak velocity using
> polyfit (base MATLAB only). Plot pause magnitude vs peak velocity, overlay
> the fit line, report slope and intercept with units, and compare them to the
> true values we simulated.

The fitted slope should land near 0.28 Hz/(cm/s) and intercept near 2 Hz —
*you know the ground truth because you simulated it*. This is the cheapest
habit in computational science: test the pipeline on data where you know the
answer, **before** touching real data.

## 2.5 Break it on purpose (the best part)

> Re-run the simulation with noise SD 8 instead of 3, and with only 15
> trials instead of 100. Refit and show me how the slope estimate changes.
> Then put it back.

You just did a power analysis by conversation. Worth internalizing: asking
"how would this fail?" costs one sentence.

## 2.6 Stretch goals (optional)

- "Wrap the simulate-and-fit in a loop over 1000 repeats and histogram the
  fitted slopes" — a bootstrap intuition-builder.
- "Make pause depth quadratic instead of linear in the simulation, but keep
  fitting a line. What does the fit residual plot look like?" — model
  misspecification, visible.

## ✅ Done when

Your `speed_tuning.m` runs end-to-end, the recovered pause-depth slope is near
0.28 Hz/(cm/s), and you can explain every line (ask the agent to walk you
through any you can't). Compare with [solutions/module2](../../solutions/module2/). Next:
[Module 3 — real behavior data](../module-3-behavior/README.md).
