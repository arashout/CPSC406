clear all
randn('seed', 317) ;
A=randn(2,5); % Locations of m=5 sensors
x=randn(2,1); % True location of x
d=sqrt(sum((A-x*ones(1,5)).^2))+0.05*randn(1,5); % Noise of m=5 sensors
d=d'; % Noise in measurements
x0 = [1000, -500]';

f = @(y) f_func(y, A, d);
df = @(y) df_func(y, A, d);
alpha_range = logspace(1, -10, 100);
max_iterations = 1e3;
epsilon = 1e-1;
% for i = 1:length(alpha_range)
%     alpha = alpha_range(i);
%     [x_hat, trace, converged] = gd(df, x0, alpha, max_iterations, epsilon);
%     if converged
%         break
%     end
% end
% figure(1)
% plot(trace)
% title("GD: Convergence trace for \alpha=" + num2str(alpha))

[x_hat, trace, converged] = gd_bt(f, df, x0, 1, 0.5, 0.5, max_iterations, epsilon);
figure(2)
plot(trace)
title("GD with BT: Convergence trace");


