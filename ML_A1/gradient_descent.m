function [x,trace] = gradient_descent(g, loss, x, iterations, stepsize)
% Summary of this function goes here
%   Detailed explanation goes here

trace = zeros(iterations, 1);
for iter = 1:iterations
    d = g(x);
    x = x + stepsize*d;
    trace(iter) = loss(x);
end

end