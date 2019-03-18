close all

d = 2;
n = 20;
k = 3;
X = rand(n, d)*20 - 20;
P = randomP(n, k);
C = rand(k, d)*mean2(X) - std2(X);

figure(1);
pf = @(h, C, P) plotFunc(h, X, C, P);
hold on
[C, P] = k_means(X, 3, 10, C, P, pf);
hold off

