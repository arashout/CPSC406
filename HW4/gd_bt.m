function [xk,trace, converged] = gd_bt(f, g, x0, s, alpha, beta, max_iters, epsilon)
trace = zeros(max_iters, 1);
xk = x0;
tk = s;

for k = 1:max_iters
    trace(k) = norm(g(xk));
    % Determine new step size
    dk = -g(xk); % Negative gradient is descent direction
    i = 0;
    tk = s;
    while f(xk) - f(xk + tk*dk) < -alpha*tk*g(xk)'*dk
        i = i + 1;
        tk = s*beta^i;
    end
    
    xk = xk + tk*dk;
    if norm(g(xk)) < epsilon
        converged = true;
        return
    elseif isnan(norm(xk)) || ~isfinite(norm(xk))
        converged = false;
        disp("Diverged to inf @ iteration: " + num2str(k));
        return
    end
end
converged = false;