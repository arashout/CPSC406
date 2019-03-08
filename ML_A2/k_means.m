function [n] = k_means(X, k, max_iter)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[n,d] = size(X);
P = randomP(n, k);
for i = 1:max_iter
    C = calcC(X, P, n, d, k);
    P = calcP(X, C, n, d, k);
end

end

function [P] = randomP(n, k)
    P = zeros(n, k);
    selections = randi([1, k], n, 1);
    for i = 1:n
        P(i, selections(i)) = 1;
    end
    % Assert
    n == sum(P * ones(k, 1))
end

function [P] = calcP(X, C, n, d, k)
P = zeros(n, k);
for i = 1:n
        [~, min_k] = min(vecnorm(X(i, :) - C, 2, 2));
        P(i, min_k) = 1; 
end
% Assert
n == sum(P * ones(k, 1))
end
function [C] = calcC(X, P, n, d, k)
C = zeros(k, d);
for i = 1:k
    ck = 1/n * X' * P * ones(k, 1);
    C(i, :) = ck;
end
end

