%% Warm-up 4: the slow script
% This script computes, for each of 200 "trials", the mean signal in a
% window around an event -- a very common neuroscience operation. It gives
% the RIGHT answer but takes far longer than it should, because it grows
% arrays inside loops and re-reads data it already has.
%
% Ask the agent to (1) measure how long it takes, (2) explain WHY it is
% slow, and (3) make it fast without changing the result.

rng(42);
fs = 1000;                                 % sample rate (Hz)
signal = randn(1, 600 * fs);               % 10 min of fake data
event_times_s = sort(rand(1, 200) * 590) + 5;
win_s = [-1, 1];

tic;
trial_means = [];
for k = 1:numel(event_times_s)
    seg = [];
    idx_start = round((event_times_s(k) + win_s(1)) * fs);
    idx_stop = round((event_times_s(k) + win_s(2)) * fs);
    for idx = idx_start:idx_stop
        seg(end + 1) = signal(idx); %#ok<SAGROW>
    end
    trial_means(end + 1) = mean(seg); %#ok<SAGROW>
end
elapsed = toc;

fprintf('computed %d trial means in %.2f s\n', numel(trial_means), elapsed);
fprintf('grand mean: %.4f\n', mean(trial_means));
