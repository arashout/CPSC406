function [xk,trace, converged] = gd(g, x0, alpha, max_iters, epsilon)
trace = zeros(max_iters, 1);
xk = x0;
for k = 1:max_iters
    trace(k) = norm(g(xk));
    xk = xk - alpha*g(xk);
    if norm(g(xk)) < epsilon
        converged = true;
        return
    elseif isnan(norm(xk)) || ~isfinite(norm(xk))
        converged = false;
        disp("Diverged to infinity @ iteration: " + num2str(k)+" - alpha" + num2str(alpha));
        return
    end
end
converged = false;