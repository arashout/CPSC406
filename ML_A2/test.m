close all

randseed(2);

d = 2;
n = 20;
k = 3;
X = rand(n, d)*20 - 20;

figure(1);
[C, P] = k_means(X, 3, 10);
M = repmat([1:1:k],n, 1);
clusters = sum(M.*P, 2);
hold on
scatter(X(:, 1), X(:, 2), 20, clusters);
scatter(C(:,1), C(:,2), 'filled');
hold off
colormap(jet(5))