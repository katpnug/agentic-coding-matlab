%% Warm-up 4 solution: the slow script, made fast
% Why the original was slow:
%   1. `seg(end+1) = ...` and `trial_means(end+1) = ...` grow arrays one
%      element at a time, forcing repeated reallocation+copy.
%   2. The inner loop copies one sample per iteration when a single
%      vectorized slice `signal(idx_start:idx_stop)` does it at once.
% The result (grand mean) is identical; only the mechanics changed.

rng(42);
fs = 1000;                                 % sample rate (Hz)
signal = randn(1, 600 * fs);               % 10 min of fake data
event_times_s = sort(rand(1, 200) * 590) + 5;
win_s = [-1, 1];

tic;
n_events = numel(event_times_s);
trial_means = zeros(1, n_events);          % preallocate (fix 1)
for k = 1:n_events
    idx_start = round((event_times_s(k) + win_s(1)) * fs);
    idx_stop = round((event_times_s(k) + win_s(2)) * fs);
    trial_means(k) = mean(signal(idx_start:idx_stop));   % vectorized (fix 2)
end
elapsed = toc;

fprintf('computed %d trial means in %.2f s\n', numel(trial_means), elapsed);
fprintf('grand mean: %.4f\n', mean(trial_means));
