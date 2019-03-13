function [C, P] = k_means(X, k, max_iter)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[n,d] = size(X);
P = randomP(n, k);
C = rand(k, d)*mean2(X) - std2(X);

for i = 1:max_iter
    P = calcP(X, C, n, d, k);
    C = calcC(X, P, n, d, k);
end

end

function [P] = randomP(n, k)
    P = zeros(n, k);
    selections = randi([1, k], n, 1);
    for i = 1:n
        P(i, selections(i)) = 1;
    end
end

function [P] = calcP(X, C, n, d, k)
P = zeros(n, k);
for i = 1:n
        [~, min_k] = min(vecnorm(X(i, :) - C, 2, 2));
        P(i, min_k) = 1; 
end
end

function [C] = calcC(X, P, n, d, k)
C = zeros(k, d);
for ki = 1:k
    p = P(:, ki);
    sp = sum(p);
    if sp ~= 0
        C(ki, :) = p'*X/sp;
    end
end
end

function [min_k]  = min_arg(xi, C)
    min_k = 1;
    k = length(C);
    min_val = norm(xi - C(1,:));
    for j = 2:k
        nrm = norm(xi - C(j, :));
        if nrm  < min_val
            min_k = j;
            min_val = nrm;
        end
    end
end