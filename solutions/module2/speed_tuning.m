%% Module 2 solution: speed-scaled Purkinje cell pauses
% Simulate 100 reaching trials with bell-shaped velocity traces and
% reach-aligned Purkinje cell pauses. Faster reaches have deeper pauses,
% inspired by work from Abigail Person, Dylan Calame, and Matt Becker.

cd(fileparts(fileparts(fileparts(mfilename('fullpath')))));  % repo root

%% 2.1 simulate
rng(7);
n_trials = 100;
time_s = (-1:0.01:1.5)';

baseline_hz = 70;               % Purkinje cell tonic baseline (~50-100 Hz)
true_intercept_hz = 2;          % pause depth at 0 cm/s, in Hz
true_slope = 0.28;              % pause-depth change per cm/s
noise_sd_hz = 3;

peak_velocity_cm_s = 5 + 45 * rand(n_trials, 1);    % uniform 5-50 cm/s

velocity_shape = exp(-0.5 * ((time_s - 0.10) / 0.12).^2);
velocity_cm_s = velocity_shape * peak_velocity_cm_s';

true_pause_depth_hz = true_intercept_hz + true_slope * peak_velocity_cm_s;
early_bump_hz = 5 * exp(-0.5 * ((time_s - 0.05) / 0.12).^2);
pause_shape = exp(-0.5 * ((time_s - 0.35) / 0.18).^2);

rate_hz = baseline_hz + early_bump_hz - pause_shape * true_pause_depth_hz' ...
    + noise_sd_hz * randn(numel(time_s), n_trials);

fprintf('mean true pause depth: %.1f Hz (predicted ~%.1f Hz)\n', ...
    mean(true_pause_depth_hz), true_intercept_hz + true_slope * mean(peak_velocity_cm_s));

%% 2.3 estimate pause magnitude from each trial
baseline_window = time_s >= -1 & time_s <= -0.3;
pause_window = time_s >= 0.25 & time_s <= 0.45;

baseline_estimate_hz = mean(rate_hz(baseline_window, :), 1)';
pause_rate_hz = mean(rate_hz(pause_window, :), 1)';
pause_depth_estimate_hz = baseline_estimate_hz - pause_rate_hz;

fprintf('mean estimated pause depth: %.1f Hz\n', mean(pause_depth_estimate_hz));

%% 2.4 fit (base MATLAB only)
coeffs = polyfit(peak_velocity_cm_s, pause_depth_estimate_hz, 1);
fit_slope = coeffs(1);
fit_intercept = coeffs(2);

fprintf('fitted slope: %.3f Hz/(cm/s)   [true %.3f]\n', fit_slope, true_slope);
fprintf('fitted intercept: %.2f Hz      [true %.2f]\n', fit_intercept, ...
    true_intercept_hz);

%% 2.2 + 2.4 trace averages and pause-depth fit
fig = figure('Color', 'w', 'Position', [100 100 900 750]);
if isprop(fig, 'Theme'), fig.Theme = 'light'; end   % consistent colors on dark-mode MATLAB (R2025a+)

color_order = [0.95 0.70 0.86
               0.82 0.45 0.78
               0.62 0.28 0.72
               0.40 0.16 0.60
               0.18 0.08 0.35];
velocity_group = zeros(n_trials, 1);
[~, sort_order] = sort(peak_velocity_cm_s);
for group_idx = 1:5
    first_trial = floor((group_idx - 1) * n_trials / 5) + 1;
    last_trial = floor(group_idx * n_trials / 5);
    velocity_group(sort_order(first_trial:last_trial)) = group_idx;
end

tiledlayout(3, 1, 'TileSpacing', 'compact', 'Padding', 'compact');
group_labels = {'0-20%', '20-40%', '40-60%', '60-80%', '80-100%'};

nexttile;
hold on;
for group_idx = 1:5
    group_trials = velocity_group == group_idx;
    plot(time_s, mean(velocity_cm_s(:, group_trials), 2), ...
        'Color', color_order(group_idx, :), 'LineWidth', 2);
end
hold off;
ylabel({'velocity', '(cm/s)'});
title('simulated reaches grouped by peak velocity');
legend(group_labels, 'Location', 'northeast');
legend boxoff;
set(gca, 'FontSize', 12, 'Box', 'off', 'TickDir', 'out');

nexttile;
hold on;
for group_idx = 1:5
    group_trials = velocity_group == group_idx;
    rate_change_hz = rate_hz(:, group_trials) - baseline_hz;
    plot(time_s, mean(rate_change_hz, 2), ...
        'Color', color_order(group_idx, :), 'LineWidth', 2);
end
plot([time_s(1) time_s(end)], [0 0], 'k--', 'LineWidth', 1);
hold off;
ylabel({'spk FR', 'change (Hz)'});
xlabel('time from reach onset (s)');
set(gca, 'FontSize', 12, 'Box', 'off', 'TickDir', 'out');

nexttile;
scatter(peak_velocity_cm_s, pause_depth_estimate_hz, 30, 'filled', ...
    'MarkerFaceColor', [0.35 0.35 0.35], 'MarkerFaceAlpha', 0.6);
hold on;
velocity_grid = linspace(5, 50, 100);
plot(velocity_grid, polyval(coeffs, velocity_grid), 'k', 'LineWidth', 2);
hold off;
xlabel('peak velocity (cm/s)');
ylabel({'pause', 'magnitude (Hz)'});
title(sprintf('pause tuning: fit %.2f Hz/(cm/s), true %.2f', ...
    fit_slope, true_slope));
set(gca, 'FontSize', 12, 'Box', 'off', 'TickDir', 'out');

exportgraphics(gcf, fullfile('solutions', 'expected_figures', ...
    'module2_speed_tuning.png'), 'Resolution', 300);
