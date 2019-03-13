function [xk,trace, status] = gd(f, g, x0, alpha, max_iters, epsilon)
trace = zeros(max_iters, 1);
xk = x0;
for k = 1:max_iters
    trace(k) = f(xk);
    dk = -g(xk);
    xk = xk + alpha*dk;
    fprintf("k = %3d norm_grad = %2.6f f_val = %2.6f\n", k, norm(dk), f(xk));
    if norm(dk) < epsilon
        status = 1;
        trace = trace(1:k);
        return
    elseif k > 2 && trace(k) > trace(k-1)
        status = -1;
        trace = trace(1:k);
        return
    elseif isnan(norm(xk)) || ~isfinite(norm(xk))
        status = -1;
        trace = trace(1:k);
        return
    end
end
status = 0;
end