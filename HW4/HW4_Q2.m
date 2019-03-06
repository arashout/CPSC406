clear all
%% Q2d-i
n = 2;
m = 5;
randn('seed', 317) ;
A=randn(n,m); % Locations of m=5 sensors
x=randn(n,1); % True location of x
d=sqrt(sum((A-x*ones(1,m)).^2))+0.05*randn(1,m); % Noise of m=5 sensors
d=d'; % Noise in measurements
x0 = [1000, -500]';

f = @(y) f_func(y, A, d);
df = @(y) df_func(y, A, d);
max_iterations = 1e3;
epsilon = 1e-1;
alpha_range = logspace(1, -10, 100);

%% Q2d-ii
% for i = 1:length(alpha_range)
%     alpha = alpha_range(i);
%     [x_hat, trace, converged] = gd(df, x0, alpha, max_iterations, epsilon);
%     if converged
%         break
%     end
% end
% figure(1)
% loglog(trace)
% title("GD: Convergence trace for \alpha=" + num2str(alpha))

%% Q2d-iii
% [x_hat, trace, converged] = gd_bt(f, df, x0, 1, 0.5, 0.5, max_iterations, epsilon);
% figure(2)
% loglog(trace)
% title("GD with BT: Convergence trace");

%% Q2d-iiii
% TODO: Why does it diverge!!!
% J_m = zeros(m, n);
% y = x0;
% for i = 1:m
%     J_vec = zeros(n, 1);
%     for j = 1:n
%         J_vec(j) = 2*(y(j) - A(j, i));
%     end
%     J_m(i, :) = J_vec';
% end
r = @(x) norm(x-A)^2 - d.^2;
J = @(x) (2*(x - A))';
warning('off', 'MATLAB:singularMatrix');
warning('off', 'MATLAB:nearlySingularMatrix');
for i = 1:length(alpha_range)
    alpha = alpha_range(i);
    [x_hat, trace, status] = gn(J, r, df, x0, alpha, max_iterations, epsilon);
    if status >= 0
        break
    end
end
warning('on', 'MATLAB:singularMatrix');
warning('on', 'MATLAB:nearlySingularMatrix');
figure(3)
loglog(trace)
title("GN: Convergence Trace for \alpha: " + num2str(alpha));

function [xk,trace, status] = gn(J_f,r_f, df, x0, alpha, max_iters, epsilon)
trace = zeros(max_iters, 1);
xk = x0;
for k = 1:max_iters
    % Early stopping conditions
    if norm(df(xk)) < epsilon
        status = 1;
        trace = trace(1:k);
        return
    elseif k > 2 && ( norm(trace(k-1)) > norm(trace(k-2)) )
        status = -1;
        return
    elseif isnan(norm(xk)) || ~isfinite(norm(xk))
        status = -1;
        return 
    end
    
    % Damped Gauss Newton
    Jk = J_f(xk);
    rk = r_f(xk);
    dk = (Jk'*Jk)\(Jk'*rk); 
    trace(k) = norm(rk);
    xk = xk - alpha*dk;
end
status = 0;
end
