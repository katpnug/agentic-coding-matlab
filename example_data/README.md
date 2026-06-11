# Example data

This folder contains the data used by the course modules. The files committed
to this repository are small enough to clone with the repo and are all you need
for **every exercise in modules 0–5**.

The *full* raw dataset (Neuropixels `continuous.dat`, full aligned `.mat`,
multi-camera videos — ~100 GB) is **not** stored on GitHub.

> **Full dataset download:** `<< TODO: add lab share path or cloud link here >>`
>
> If you download the full dataset, place the `motive_tracking/` and
> `markerless_tracking/` folders inside this `example_data/` folder. They are
> gitignored, so git will not try to upload them.

## Files committed to the repo

| File | Size | What it is |
|---|---|---|
| `reach_subset.mat` | ~20 MB | **Main course dataset.** Preprocessed head-fixed reaching session: reach events + sorted spike times for 10 units. Used in modules 3 and 4. |
| `20250612_hFix007.mat` | ~8 MB | The *raw* behavior session file as saved by the rig software (Motive/OptiTrack tracking). Intentionally messy — used as a "real-world data" example. |
| `spike_sorting_tables/cluster_*.tsv` | <100 KB | Kilosort/Phy spike-sorting summary tables for the full recording (cluster quality, depth, firing rate, labels). |

## `reach_subset.mat` data dictionary

One head-fixed reaching session (mouse `hFix007`, 2025-06-12) with simultaneous
Neuropixels recording. Behavior and spikes share the same clock (seconds);
spike times span 0–3385 s and reach events span ~35–3365 s.

Load it with:

```matlab
data = load('example_data/reach_subset.mat');
```

### `ReachS` — 1×159 struct array, one element per detected reach

| Field | Type/size | Meaning |
|---|---|---|
| `filtered` | 601×9 double | Filtered kinematics in a 5 s window around the reach, sampled at ~120 Hz. Column 1 = time (s, session clock); columns 2–4 = hand x, y, z position (m); columns 5–9 = additional derived kinematic signals. |
| `filtered_orig` | 601×8 double | Same window before the final filtering step. |
| `out` | N×9 double | Samples belonging to the detected *outward* reach segment (same columns as `filtered`). `out(1,1)` is a reasonable "reach onset" time; the window center `filtered(301,1)` is a more robust alignment point. |
| `qm` | scalar | Quality metric for the reach detection. |
| `exclude` | scalar | 1 = flagged for exclusion (7 of 159 reaches). |
| `sucfail` | scalar or empty | `1` = successful reach (44 reaches). Empty = not marked successful. |

### `cellData` — 1×10 struct array, one element per sorted unit

| Field | Type/size | Meaning |
|---|---|---|
| `cluster_ID` | scalar | Kilosort/Phy cluster id (cross-reference with `spike_sorting_tables/cluster_info.tsv`). |
| `spike_times` | N×1 double | Spike times in seconds, same clock as `ReachS`. 50k–360k spikes per unit. |
| `fr` | scalar | Mean firing rate (Hz). |
| `channel`, `depth` | scalars | Probe channel and depth (µm) of the unit. |
| `phy_quality`, `ks_quality` | string | Manual (Phy) and automatic (Kilosort) quality labels. |
| `Unstable` | char | `'y'` if the unit was flagged unstable over the session. |
| `manual__Type` | char | Manually assigned cell type label. |

> Note: the original file also contains 1 ms / 10 ms binned firing-rate
> matrices (`Bin1`, `Bin10`, `Bin10smooth`). They were removed from this subset
> to fit GitHub's file-size limits — recompute them from `spike_times` if
> needed (good agent exercise!).

### Other variables

| Variable | Meaning |
|---|---|
| `exp_details` | Session metadata (experimenter, datetime, experiment type/description, reach detection threshold). |
| `qm_thresh` | Quality-metric threshold used during preprocessing. |
| `ttl_base` | TTL time base offset (s) used to align behavior to the ephys clock. |
| `subset_info` | Provenance note about how this subset was made. |

## `20250612_hFix007.mat` (raw session)

Saved directly by the rig control script, so it contains many global workspace
variables. The interesting ones:

| Variable | Meaning |
|---|---|
| `dta` | 1×4 cell of raw Motive/OptiTrack tracking data streams. |
| `r_act_time` | 191×1 reach activation (threshold-crossing) times. |
| `suc` | 50×1 success event times. |

This file is used in the course to practice pointing an agent at an
unfamiliar, undocumented data file and asking it to figure out what's inside.

## `spike_sorting_tables/`

Standard Phy curation tables (tab-separated). `cluster_info.tsv` columns:
`cluster_id`, `Amplitude`, `ContamPct`, `KSLabel`, `amp`, `ch`, `depth`, `fr`,
`group`, `n_spikes`, `neuron_type`, `sh`, `unstable`. The 10 units in
`reach_subset.mat` correspond to rows here via `cluster_id`.
