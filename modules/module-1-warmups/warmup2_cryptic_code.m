%% Warm-up 2: cryptic code
% This script WORKS, but whoever wrote it (a grad student at 3 am) made it
% unreadable. Your job, via the agent: find out what it does, then make it
% readable -- good names, comments, sections -- WITHOUT changing behavior.

rng(0);
a = 0:0.001:2;
b = zeros(size(a));
b(rand(size(a)) < 0.015) = 1;
c = 0.05;
d = round(c / 0.001);
e = ones(1, d) / d;
f = conv(b, e, 'same') / 0.001;
g = find(b);
h = diff(g) * 0.001;
figure;
subplot(2, 1, 1); plot(a, f, 'k'); xlim([0 2]);
subplot(2, 1, 2); histogram(h, 20);
fprintf('%d %.2f %.3f\n', numel(g), numel(g) / 2, mean(h));
