%% Warm-up 3: the ugly figure
% This script runs fine and the analysis is correct: it plots average
% "tuning curves" for three simulated neurons. But the figure would get
% your poster laughed out of SfN. Ask the agent to make it
% publication-quality. Be specific about what you want!

angles_deg = 0:30:330;
preferred = [90, 180, 270];
n_neurons = numel(preferred);

rng(1);
responses = zeros(n_neurons, numel(angles_deg));
for n = 1:n_neurons
    tuning = 10 + 25 * exp(cosd(angles_deg - preferred(n)) - 1);
    responses(n, :) = tuning + randn(size(tuning)) * 2;
end

figure;
plot(angles_deg, responses(1, :));
hold on;
plot(angles_deg, responses(2, :));
plot(angles_deg, responses(3, :));
title('data');
