function [x,trace] = bt_linesearch(A, b, g, x, iterations, s, alpha, beta)
% Summary of this function goes here
%   Detailed explanation goes here

trace = zeros(iterations, 1);
stepsize = 1/length(b);
for iter = 1:iterations
    while 
    x = x - alpha*g(A,b,x);
    trace(iter) = norm(A*x - b, 2);
end

end