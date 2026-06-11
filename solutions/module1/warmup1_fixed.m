%% Warm-up 1 solution: fix the error
% Two bugs in the original:
%   1. `histcounts(spike_times, bin_edge)` -- typo, the variable is
%      `bin_edges` (Unrecognized variable error).
%   2. `bar(bin_edges, counts)` -- bin_edges has one more element than
%      counts (edges vs bins), so bar() errors on length mismatch. Plot
%      against the bin centers instead.

cd(fileparts(fileparts(fileparts(mfilename('fullpath')))));  % repo root

rate_hz = 20;            % mean firing rate
duration_s = 5;          % length of the simulated train
bin_width_s = 0.1;       % 100 ms bins

% draw spike times from a homogeneous Poisson process
% (exponential inter-spike intervals)
isi = -log(rand(1, 2 * rate_hz * duration_s)) / rate_hz;
spike_times = cumsum(isi);
spike_times = spike_times(spike_times <= duration_s);

% bin the spikes
bin_edges = 0:bin_width_s:duration_s;
counts = histcounts(spike_times, bin_edges);                 % fix 1
bin_centers = bin_edges(1:end-1) + bin_width_s / 2;          % fix 2

% plot
fig = figure('Color', 'w');
if isprop(fig, 'Theme'), fig.Theme = 'light'; end   % consistent colors on dark-mode MATLAB (R2025a+)
bar(bin_centers, counts, 1);
xlabel('time (s)');
ylabel('spikes per bin');
title(sprintf('simulated %d hz poisson train', rate_hz));

exportgraphics(gcf, fullfile('solutions', 'expected_figures', ...
    'module1_warmup1.png'), 'Resolution', 150);
