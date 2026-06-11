%% Warm-up 2 solution: cryptic code, made readable
% What the original does: simulates a 2 s spike train on a 1 ms grid,
% computes a firing-rate trace with a 50 ms boxcar, and shows the
% inter-spike-interval (ISI) distribution. Printed numbers: spike count,
% mean rate (Hz), mean ISI (s). Behavior is identical to the original
% (same operations in the same order on the same random draws).

cd(fileparts(fileparts(fileparts(mfilename('fullpath')))));  % repo root

rng(0);   % same seed as the original, so the printed numbers match exactly

%% parameters
dt_s = 0.001;                 % time step (was the magic number 0.001)
duration_s = 2;
spike_prob_per_bin = 0.015;   % ~15 Hz expected rate
boxcar_width_s = 0.05;        % 50 ms smoothing window

%% simulate a Bernoulli (approximately Poisson) spike train
time_s = 0:dt_s:duration_s;
spike_train = zeros(size(time_s));
spike_train(rand(size(time_s)) < spike_prob_per_bin) = 1;

%% firing-rate trace: boxcar-smoothed spike train, converted to Hz
boxcar_n_bins = round(boxcar_width_s / dt_s);
boxcar_kernel = ones(1, boxcar_n_bins) / boxcar_n_bins;
rate_hz = conv(spike_train, boxcar_kernel, 'same') / dt_s;

%% inter-spike intervals
spike_idx = find(spike_train);
isi_s = diff(spike_idx) * dt_s;

%% plot: rate trace on top, ISI histogram below
fig = figure('Color', 'w');
if isprop(fig, 'Theme'), fig.Theme = 'light'; end   % consistent colors on dark-mode MATLAB (R2025a+)
subplot(2, 1, 1);
plot(time_s, rate_hz, 'k');
xlim([0 duration_s]);
xlabel('time (s)');
ylabel('rate (Hz)');
subplot(2, 1, 2);
histogram(isi_s, 20);
xlabel('inter-spike interval (s)');
ylabel('count');

%% summary: n spikes, mean rate over the 2 s, mean ISI
fprintf('%d %.2f %.3f\n', numel(spike_idx), numel(spike_idx) / duration_s, ...
    mean(isi_s));

exportgraphics(gcf, fullfile('solutions', 'expected_figures', ...
    'module1_warmup2.png'), 'Resolution', 150);
