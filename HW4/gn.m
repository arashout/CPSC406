function [xk,trace] = gn(A_f,r_f, x0, max_iters, epsilon)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
trace = zeros(max_iters, 1);
xk = x0;
for k = 2:max_iters
    Ak = A_f(xk);
    rk = r_f(xk);
    bk = Ak*xk - rk;
    trace(k) = norm(rk);
    xk = Ak\bk;
    
%     if abs(trace(k-1) - trace(k)) < epsilon
%         trace = trace(1:k);
%     end
end
