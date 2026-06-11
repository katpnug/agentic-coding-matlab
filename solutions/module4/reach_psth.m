%% Module 4 solution: event-aligned spikes
% Raster + PSTH aligned to reach onset, success-vs-other comparison for all
% 10 units, and a shuffle control. Base MATLAB only.

f = mfilename('fullpath');          % empty when run section-by-section
if ~isempty(f)
    cd(fileparts(fileparts(fileparts(f))));
end
if ~exist(fullfile('example_data', 'reach_subset.mat'), 'file')
    error('Cannot find example_data. Run the whole file with F5, or cd to the repo root first.');
end

data = load(fullfile('example_data', 'reach_subset.mat'));
ReachS = data.ReachS;
cellData = data.cellData;

%% 4.1 event times: reach onsets
keep = ~arrayfun(@(x) ~isempty(x.exclude) && any(x.exclude(:)), ReachS);
onsets = nan(size(ReachS));
for i = 1:numel(ReachS)
    if ~isempty(ReachS(i).out)
        onsets(i) = ReachS(i).out(1, 1);
    else
        onsets(i) = ReachS(i).filtered(301, 1);   % window center fallback
    end
end
is_success = arrayfun(@(x) ~isempty(x.sucfail) && isequal(x.sucfail, 1), ReachS);

onsets_kept = onsets(keep);
success_kept = is_success(keep);
fprintf('usable reaches: %d (of %d), successful: %d\n', ...
    sum(keep), numel(ReachS), sum(success_kept));

%% PSTH settings (see modules/module-5 skill for the conventions)
win_s = [-2, 3];
bin_w = 0.05;                               % 50 ms bins
edges = win_s(1):bin_w:win_s(2);
centers = edges(1:end-1) + bin_w / 2;
smooth_sd_s = 0.1;                          % 100 ms gaussian smoothing
kern_t = -3*smooth_sd_s:bin_w:3*smooth_sd_s;
kern = exp(-kern_t.^2 / (2 * smooth_sd_s^2));
kern = kern / sum(kern);

% helper: trial x bin count matrix for one unit and a set of events
align_counts = @(spk, evts) cell2mat(arrayfun(@(e) ...
    histcounts(spk - e, edges), evts(:), 'UniformOutput', false));

%% 4.2 + 4.3 raster and PSTH for unit 3
unit = 8;
spk = cellData(unit).spike_times;

fig = figure('Color', 'w', 'Position', [100 100 700 700]);
if isprop(fig, 'Theme'), fig.Theme = 'light'; end   % consistent colors on dark-mode MATLAB (R2025a+)
ax1 = subplot(3, 1, [1 2]);
hold on;
for i = 1:numel(onsets_kept)
    rel = spk(spk >= onsets_kept(i) + win_s(1) & ...
              spk <= onsets_kept(i) + win_s(2)) - onsets_kept(i);
    plot(rel, i * ones(size(rel)), '.', 'Color', 'k', 'MarkerSize', 2);
end
xline(0, 'r-', 'LineWidth', 1);
hold off;
ylabel('reach #');
ylim([0 numel(onsets_kept) + 1]);
title(sprintf('unit %d (cluster %d, depth %d \\mum, %s)', unit, ...
    cellData(unit).cluster_ID, cellData(unit).depth, ...
    cellData(unit).phy_quality));
set(ax1, 'FontSize', 12, 'Box', 'off', 'TickDir', 'out');

ax2 = subplot(3, 1, 3);
counts = align_counts(spk, onsets_kept);
psth = conv(mean(counts, 1) / bin_w, kern, 'same');
plot(centers, psth, 'k', 'LineWidth', 2);
xline(0, 'r-');
xlabel('time from reach onset (s)');
ylabel('rate (Hz)');
linkaxes([ax1 ax2], 'x');
xlim(win_s);
set(ax2, 'FontSize', 12, 'Box', 'off', 'TickDir', 'out');
exportgraphics(gcf, fullfile('solutions', 'expected_figures', ...
    'module4_raster_psth_unit3.png'), 'Resolution', 300);

% sanity check: PSTH mean vs session mean rate
fprintf('unit %d: session fr %.1f Hz, PSTH window mean %.1f Hz\n', unit, ...
    cellData(unit).fr, mean(psth));

%% 4.4 + 4.5 success vs other, all 10 units
colors = struct('suc', [0 0.4470 0.7410], 'other', [0.5 0.5 0.5]);

fig = figure('Color', 'w', 'Position', [50 50 1400 600]);
if isprop(fig, 'Theme'), fig.Theme = 'light'; end   % consistent colors on dark-mode MATLAB (R2025a+)
tl = tiledlayout(2, 5, 'TileSpacing', 'compact');
for u = 1:numel(cellData)
    nexttile;
    spk_u = cellData(u).spike_times;
    hold on;
    for grp = ["suc", "other"]
        if grp == "suc", sel = success_kept; else, sel = ~success_kept; end
        c = align_counts(spk_u, onsets_kept(sel)) / bin_w;
        m = conv(mean(c, 1), kern, 'same');
        sem = conv(std(c, 0, 1) / sqrt(size(c, 1)), kern, 'same');
        fill([centers, fliplr(centers)], [m + sem, fliplr(m - sem)], ...
            colors.(grp), 'FaceAlpha', 0.25, 'EdgeColor', 'none');
        plot(centers, m, 'Color', colors.(grp), 'LineWidth', 1.5);
    end
    xline(0, 'k:');
    hold off;
    xlim(win_s);
    title(sprintf('clu %d | %d \\mum | %s', cellData(u).cluster_ID, ...
        cellData(u).depth, cellData(u).phy_quality), 'FontSize', 9);
    set(gca, 'Box', 'off', 'TickDir', 'out');
end
xlabel(tl, 'time from reach onset (s)');
ylabel(tl, 'firing rate (Hz)');
title(tl, sprintf( ...
    'success (blue, n = %d) vs other (gray, n = %d), mean \\pm SEM', ...
    sum(success_kept), sum(~success_kept)));
exportgraphics(gcf, fullfile('solutions', 'expected_figures', ...
    'module4_all_units_grid.png'), 'Resolution', 300);

%% 4.6 shuffle control: circularly shift event times
rng(1);
t_min = min(onsets_kept) - 60;
t_max = max(onsets_kept) + 60;
shift = t_min + rand * (t_max - t_min);
onsets_shuf = mod(onsets_kept - t_min + shift, t_max - t_min) + t_min;

psth_real = conv(mean(align_counts(spk, onsets_kept), 1) / bin_w, kern, 'same');
psth_shuf = conv(mean(align_counts(spk, onsets_shuf), 1) / bin_w, kern, 'same');

fig = figure('Color', 'w');
if isprop(fig, 'Theme'), fig.Theme = 'light'; end   % consistent colors on dark-mode MATLAB (R2025a+)
plot(centers, psth_real, 'k', 'LineWidth', 2);
hold on;
plot(centers, psth_shuf, 'Color', [0.85 0.33 0.10], 'LineWidth', 2);
xline(0, 'k:');
hold off;
xlabel('time from reach onset (s)');
ylabel('rate (Hz)');
title(sprintf('unit %d: real vs shuffled reach onsets', unit));
legend({'real onsets', 'shuffled onsets'}, 'Location', 'best');
set(gca, 'FontSize', 12, 'Box', 'off', 'TickDir', 'out');
exportgraphics(gcf, fullfile('solutions', 'expected_figures', ...
    'module4_shuffle_control.png'), 'Resolution', 300);
