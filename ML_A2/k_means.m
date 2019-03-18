function [C, P] = k_means(X, k, max_iter, C, P, pf)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[n,d] = size(X);
h = 0;
for i = 1:max_iter
    P = calcP(X, C, n, d, k);
    C = calcC(X, P, n, d, k);
    h = pf(h,C,P);
end

end

function [P] = calcP(X, C, n, ~, k)
P = zeros(n, k);
for i = 1:n
        [~, min_k] = min(vecnorm(X(i, :) - C, 2, 2));
        P(i, min_k) = 1; 
end
end

function [C] = calcC(X, P, ~, d, k)
C = zeros(k, d);
for ki = 1:k
    p = P(:, ki);
    sp = sum(p);
    if sp ~= 0
        C(ki, :) = p'*X/sp;
    end
end
end
