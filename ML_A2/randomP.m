function [P] = randomP(n, k)
    P = zeros(n, k);
    selections = randi([1, k], n, 1);
    for i = 1:n
        P(i, selections(i)) = 1;
    end
end