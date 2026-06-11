%% Module 3 solution: reach kinematics
% Explore ReachS, plot one reach, overlay all aligned reaches, and compare
% successful vs other reaches.

cd(fileparts(fileparts(fileparts(mfilename('fullpath')))));  % repo root

data = load(fullfile('example_data', 'reach_subset.mat'));
ReachS = data.ReachS;
n_reaches = numel(ReachS);

%% 3.2 one reach: 3-D trajectory and per-axis traces
r = ReachS(12);
t = r.filtered(:, 1);                      % time (s, session clock)
xyz = r.filtered(:, 2:4);                  % hand position (m)
if ~isempty(r.out)
    onset_t = r.out(1, 1);                 % first sample of outward reach
else
    onset_t = r.filtered(301, 1);          % fallback: window center
end

fig = figure('Color', 'w');
if isprop(fig, 'Theme'), fig.Theme = 'light'; end   % consistent colors on dark-mode MATLAB (R2025a+)
subplot(2, 1, 1);
plot3(xyz(:, 1), xyz(:, 2), xyz(:, 3), 'k');
grid on;
xlabel('x (m)'); ylabel('y (m)'); zlabel('z (m)');
title('reach 12: hand trajectory');

subplot(2, 1, 2);
plot(t, xyz, 'LineWidth', 1);
hold on;
xline(onset_t, 'r--', 'reach onset');
hold off;
xlabel('time (s)');
ylabel('position (m)');
legend({'x', 'y', 'z'}, 'Location', 'best');
set(findall(gcf, 'Type', 'axes'), 'FontSize', 11, 'Box', 'off');
exportgraphics(gcf, fullfile('solutions', 'expected_figures', ...
    'module3_single_reach.png'), 'Resolution', 300);

%% 3.3 all reaches, aligned on the window center
% the 5 s windows are reach-centered: sample 301 of 601 is the center
center_idx = 301;
keep = ~arrayfun(@(x) ~isempty(x.exclude) && any(x.exclude(:)), ReachS);
t_rel = (ReachS(1).filtered(:, 1) - ReachS(1).filtered(center_idx, 1));

z_aligned = nan(sum(keep), 601);
kept_idx = find(keep);
for i = 1:numel(kept_idx)
    z_aligned(i, :) = ReachS(kept_idx(i)).filtered(:, 4)';
end

fig = figure('Color', 'w');
if isprop(fig, 'Theme'), fig.Theme = 'light'; end   % consistent colors on dark-mode MATLAB (R2025a+)
plot(t_rel, z_aligned', 'Color', [0.7 0.7 0.7 0.4]);
hold on;
plot(t_rel, mean(z_aligned, 1, 'omitnan'), 'k', 'LineWidth', 2.5);
hold off;
xlabel('time from window center (s)');
ylabel('hand z-position (m)');
title(sprintf('all reaches aligned (n = %d, excluded %d)', ...
    sum(keep), n_reaches - sum(keep)));
set(gca, 'FontSize', 12, 'Box', 'off', 'TickDir', 'out');
exportgraphics(gcf, fullfile('solutions', 'expected_figures', ...
    'module3_aligned_overlay.png'), 'Resolution', 300);

%% 3.4 successful vs the rest
is_success = arrayfun(@(x) ~isempty(x.sucfail) && isequal(x.sucfail, 1), ReachS);
grp_suc = keep & is_success;
grp_other = keep & ~is_success;

mean_trace = @(sel) mean(cell2mat(arrayfun(@(x) x.filtered(:, 4), ...
    ReachS(sel), 'UniformOutput', false)), 2, 'omitnan');

fig = figure('Color', 'w');
if isprop(fig, 'Theme'), fig.Theme = 'light'; end   % consistent colors on dark-mode MATLAB (R2025a+)
plot(t_rel, mean_trace(grp_suc), 'Color', [0 0.4470 0.7410], 'LineWidth', 2);
hold on;
plot(t_rel, mean_trace(grp_other), 'Color', [0.5 0.5 0.5], 'LineWidth', 2);
hold off;
xlabel('time from window center (s)');
ylabel('mean hand z-position (m)');
title('successful vs other reaches');
legend({sprintf('successful (n = %d)', sum(grp_suc)), ...
    sprintf('other (n = %d)', sum(grp_other))}, 'Location', 'best');
set(gca, 'FontSize', 12, 'Box', 'off', 'TickDir', 'out');
exportgraphics(gcf, fullfile('solutions', 'expected_figures', ...
    'module3_success_vs_other.png'), 'Resolution', 300);
