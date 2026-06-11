%% Warm-up 3 solution: the figure, rescued
% Same simulated data and seed as the original; only the presentation
% changed: labels with units, legend with preferred directions, 90-degree
% ticks, bigger fonts, no box, exported at high resolution.

cd(fileparts(fileparts(fileparts(mfilename('fullpath')))));  % repo root

angles_deg = 0:30:330;
preferred = [90, 180, 270];
n_neurons = numel(preferred);

rng(1);
responses = zeros(n_neurons, numel(angles_deg));
for n = 1:n_neurons
    tuning = 10 + 25 * exp(cosd(angles_deg - preferred(n)) - 1);
    responses(n, :) = tuning + randn(size(tuning)) * 2;
end

fig = figure('Color', 'w');
if isprop(fig, 'Theme'), fig.Theme = 'light'; end   % consistent colors on dark-mode MATLAB (R2025a+)
hold on;
colors = lines(n_neurons);
for n = 1:n_neurons
    plot(angles_deg, responses(n, :), 'o-', ...
        'Color', colors(n, :), 'MarkerFaceColor', colors(n, :), ...
        'LineWidth', 1.5, ...
        'DisplayName', sprintf('neuron %d (pref. %d\\circ)', n, preferred(n)));
end
hold off;

xlabel('stimulus direction (\circ)');
ylabel('response (spikes/s)');
title('direction tuning of three simulated neurons');
legend('Location', 'northeastoutside');
xticks(0:90:360);
xlim([0 330]);
set(gca, 'FontSize', 12, 'Box', 'off', 'TickDir', 'out');

exportgraphics(gcf, fullfile('solutions', 'expected_figures', ...
    'module1_warmup3.png'), 'Resolution', 300);
