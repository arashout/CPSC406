function [x,trace] = gradient_descent_btls(f, g, l, x, iterations, s, alpha, beta)
% Summary of this function goes here
%   Detailed explanation goes here

trace = zeros(iterations, 1);
for iter = 1:iterations
    grad = g(x);
    d = -grad; % Search Direction
    t = 1;
    f(x)
    while f(x + t*d) < ( f(x) + alpha*t*grad'*d)
        t = t*beta;
    end
    x = x + t*d;
    trace(iter) = l(x);
end

end