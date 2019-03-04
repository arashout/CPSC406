clear all

%% Q1c
load('hw4_1b.mat');
lambdas = [1, 0.01, 10];
k = length(lambdas);

figure(1)
hold on
leg = cell(k+1, 1);
plot(x0);
title('Q1b')
leg{1} = 'x0';
for i = 1:k
    y = lambdas(i);
    cvx_begin quiet
        variable x(n)
        minimize( 0.5*(A*x-b)'*(A*x-b)  + y*norm(x, 1) )
    cvx_end
    plot(x, '--')
    leg{i+1} = strcat('\lambda=', num2str(y));
end
hold off
legend(leg)

%% Q1d
lambdas = logspace(-3, 3, 100);
k = length(lambdas);
f1_res = zeros(k, 1);
f2_res = zeros(k, 1);
signal_res = zeros(k, n);

figure(2)
for i = 1:k
    y = lambdas(i);
    cvx_begin quiet
        variable x(n)
        minimize( 0.5*(A*x-b)'*(A*x-b) + y*norm(x, 1) )
    cvx_end
    f1_res(i)= 0.5*norm(A*x - b);
    f2_res(i) = norm(x, 1);
    signal_res(i, :) = x;
end
plot(f1_res, f2_res);
title('Q1d: Pareto Frontier')
xlabel('f1')
ylabel('f2')

%% Q1e
load('hw4_1e.mat');

lambdas = [1, 0.01, 10];
k = length(lambdas);

figure(3)
hold on
leg = cell(k+1, 1);
plot(x0);
hold on
title('Q1e')
leg{1} = 'x0';

D = diag(ones(n, 1)) + diag(-ones(n-1, 1), 1);
D = D(1:end-1, :);
for i = 1:k
    y = lambdas(i);
    cvx_begin quiet
        variable x(n)
        minimize( 0.5*(A*x-b)'*(A*x-b)  + y*norm(D*x, 1) )
    cvx_end
    plot(x, '--')
    leg{i+1} = strcat('\lambda=', num2str(y));
end
hold off
legend(leg)

%%Q1f
lambdas = logspace(-3, 3, 100);
k = length(lambdas);
f1_res = zeros(k, 1);
f2_res = zeros(k, 1);
signal_res = zeros(k, n);

figure(4)
for i = 1:k
    y = lambdas(i);
    cvx_begin quiet
        variable x(n)
        minimize( 0.5*(A*x-b)'*(A*x-b)  + y*norm(D*x, 1) )
    cvx_end
    f1_res(i)= 0.5*(A*x-b)'*(A*x-b);
    f2_res(i) = norm(x, 1);
    signal_res(i, :) = x;
end
plot(f1_res, f2_res);
title('Q1f: Pareto Frontier')
xlabel('f1')
ylabel('f2')