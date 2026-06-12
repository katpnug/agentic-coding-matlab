---
name: dark-theme-figure
description: Dark presentation figure conventions for MATLAB plots. Use when asked to make a figure for a black or dark slide background, dark theme, transparent-background export, presentation-ready dark figure, talk figure on a dark background, or poster figure on a dark background.
---

# Dark theme figure conventions

Follow these conventions when the user wants MATLAB figures that will be
shown on a black or dark presentation background. Keep the scientific content
from any analysis-specific skill, and apply this skill only to the figure
appearance and export settings.

## Overall style

- Use a black figure background for direct display:
  `fig = figure('Color', 'k');`
- If the figure will be placed on a black slide, use transparent export when
  possible so the slide background shows through.
- Use black axes backgrounds unless the plot needs a transparent axes
  background for overlaying on another graphic.
- Set axis, label, title, legend, and colorbar text to white.
- Use font size at least 14 for slide figures. Use 16 or larger when the
  figure has few panels or will be projected in a large room.
- Use line widths of at least 1.5 for data traces and 1.0 for reference lines.
- Keep `box off` and `TickDir` set to `out` unless the plot type requires a
  boxed axis.

## MATLAB property pattern

Apply these properties to each axes after plotting:

```matlab
ax = gca;
ax.Color = 'k';
ax.XColor = 'w';
ax.YColor = 'w';
ax.FontSize = 14;
ax.LineWidth = 1;
ax.TickDir = 'out';
box off

xlabel('Time from reach onset (s)', 'Color', 'w');
ylabel('Firing rate (Hz)', 'Color', 'w');
title('Unit 3 PSTH', 'Color', 'w');
```

For tiled figures, apply the same settings to every axes:

```matlab
allAxes = findall(fig, 'Type', 'axes');
for iAx = 1:numel(allAxes)
    allAxes(iAx).Color = 'k';
    allAxes(iAx).XColor = 'w';
    allAxes(iAx).YColor = 'w';
    allAxes(iAx).FontSize = 14;
    allAxes(iAx).LineWidth = 1;
    allAxes(iAx).TickDir = 'out';
    box(allAxes(iAx), 'off');
end
```

## Colors

- Choose colors for contrast on black, not for how they look on white.
- Prefer bright, distinct colors:
  - cyan `[0.00 0.75 1.00]`
  - orange `[1.00 0.55 0.00]`
  - green `[0.20 0.90 0.35]`
  - magenta `[1.00 0.30 0.85]`
  - light gray `[0.75 0.75 0.75]`
- Avoid dark blue, dark red, dark purple, and medium gray lines on black.
- If another skill defines scientific color meanings, preserve those meanings
  when possible, but brighten low-contrast colors so they remain readable.
- Use semi-transparent fills sparingly. On black, shaded error bands often
  need brighter face colors and lower alpha values than on white.

## Legends, colorbars, and annotations

- Set legend text to white and the legend background to black or transparent.
- Set legend edge color to a dark gray or remove the box.
- Set colorbar text to white.
- Set annotation, `xline`, and `yline` labels to white.
- Reference lines should usually be white, light gray, or a muted high-contrast
  color.

Example:

```matlab
lgd = legend('Success', 'Other', 'Location', 'best');
lgd.TextColor = 'w';
lgd.Color = 'k';
lgd.EdgeColor = [0.3 0.3 0.3];

xline(0, '-', 'reach onset', ...
    'Color', [0.85 0.85 0.85], ...
    'LabelVerticalAlignment', 'bottom', ...
    'LabelHorizontalAlignment', 'left');
```

## Export

- Save shareable figures to `outputs/` with descriptive names.
- Use 300 dpi PNG for course figures.
- For MATLAB R2021a+, prefer `exportgraphics`.
- Use transparent background when the figure will be placed on a dark slide:

```matlab
if ~exist('outputs', 'dir')
    mkdir('outputs');
end

exportgraphics(fig, fullfile('outputs', 'dark_psth_unit3.png'), ...
    'Resolution', 300, ...
    'BackgroundColor', 'none');
```

- If transparent export is not appropriate, export with black background:

```matlab
exportgraphics(fig, fullfile('outputs', 'dark_psth_unit3.png'), ...
    'Resolution', 300, ...
    'BackgroundColor', 'black');
```

## Final check

Before presenting the figure, check:

- All labels, tick labels, titles, legends, and colorbars are readable.
- Data colors are distinguishable from each other and from the background.
- Shaded error bands do not hide the mean traces.
- The exported PNG still has the expected black or transparent background.
- The figure still follows any analysis-specific conventions from other
  loaded skills.
