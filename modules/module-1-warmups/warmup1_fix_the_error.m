%% Warm-up 1: fix the error
% This script is SUPPOSED to simulate 5 seconds of a Poisson spike train
% and plot the spike count in 100 ms bins. It crashes. Ask your agent to
% run it, read the error, and fix it -- without changing what it does.

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
counts = histcounts(spike_times, bin_edge);

% plot
figure;
bar(bin_edges, counts);
xlabel('time (s)');
ylabel('spikes per bin');
title(sprintf('simulated %d hz poisson train', rate_hz));
