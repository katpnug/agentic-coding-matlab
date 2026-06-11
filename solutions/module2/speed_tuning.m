%% Module 2 solution: speed tuning of a simulated neuron
% Simulate 100 reaching trials where firing rate depends linearly on reach
% speed, recover the relationship with a linear fit, and check the fit
% against the known ground truth.

cd(fileparts(fileparts(fileparts(mfilename('fullpath')))));  % repo root

%% 2.1 simulate
rng(7);
n_trials = 100;
true_intercept_hz = 8;          % baseline rate
true_slope = 0.6;               % Hz per cm/s
noise_sd_hz = 4;

speed_cm_s = 5 + 45 * rand(n_trials, 1);            % uniform 5-50 cm/s
rate_hz = true_intercept_hz + true_slope * speed_cm_s ...
    + noise_sd_hz * randn(n_trials, 1);

fprintf('mean firing rate: %.1f Hz (predicted ~%.1f Hz)\n', mean(rate_hz), ...
    true_intercept_hz + true_slope * mean(speed_cm_s));

%% 2.3 fit (base MATLAB only)
coeffs = polyfit(speed_cm_s, rate_hz, 1);
fit_slope = coeffs(1);
fit_intercept = coeffs(2);
fprintf('fitted slope: %.3f Hz/(cm/s)   [true %.3f]\n', fit_slope, true_slope);
fprintf('fitted intercept: %.2f Hz      [true %.2f]\n', fit_intercept, ...
    true_intercept_hz);

%% 2.2 + 2.3 scatter with overlaid fit
fig = figure('Color', 'w');
if isprop(fig, 'Theme'), fig.Theme = 'light'; end   % consistent colors on dark-mode MATLAB (R2025a+)
scatter(speed_cm_s, rate_hz, 30, 'filled', 'MarkerFaceAlpha', 0.6);
hold on;
speed_grid = linspace(5, 50, 100);
plot(speed_grid, polyval(coeffs, speed_grid), 'k', 'LineWidth', 2);
hold off;
xlabel('reach speed (cm/s)');
ylabel('firing rate (Hz)');
title(sprintf('speed tuning: fit %.2f Hz/(cm/s), true %.2f', ...
    fit_slope, true_slope));
legend({'trials', 'linear fit'}, 'Location', 'northwest');
set(gca, 'FontSize', 12, 'Box', 'off', 'TickDir', 'out');

exportgraphics(gcf, fullfile('solutions', 'expected_figures', ...
    'module2_speed_tuning.png'), 'Resolution', 300);
