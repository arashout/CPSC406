randn('seed', 317) ;
A=randn(2,5); % Locations of m=5 sensors
x=randn(2,1); % True location of x
d=sqrt(sum((A-x*ones(1,5)).^2))+0.05*randn(1,5); % Noise of m=5 sensors
d=d'; % Noise in measurements
x0 = [1000, -500]';

f_func(x0, A, d)
df_func(x0, A, d)

df = @(y) df_func(y, A, d);
alpha_range = logspace(1, -10, 100);
max_iterations = 1e6;
for i = 1:length(alpha_range)
    alpha = alpha_range(i);
    [x, trace, converged] = gd(df, x0, alpha, max_iterations, 1e-1);
    if converged
        break
    end
end
figure(1)
plot(trace)
title("Convergence trace for \alpha=" + num2str(alpha))

