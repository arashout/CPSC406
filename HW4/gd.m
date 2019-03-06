function [xk,trace, converged] = gd(g, x0, alpha, max_iters, epsilon)
trace = zeros(max_iters, 1);
xkp = x0;
for k = 1:max_iters
    trace(k) = norm(g(xkp));
    xk = xkp - alpha*g(xkp);
    if norm(g(xk) - g(xkp)) < epsilon
        converged = true;
        return
    elseif isnan(norm(xk)) || ~isfinite(norm(xk))
        converged = false;
        disp("Ended early at iteration: " + num2str(k)+" - alpha" + num2str(alpha));
        return
    end
    xkp = xk;
end
converged = false;
trace = trace(1:k); % Remove the first dummy trace value