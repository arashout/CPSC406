clear all
load('hw4_1b.mat');

%TODO: How to square norm

%% Q1
lambdas = [1, 0.01, 10];
k = length(lambdas);
% plot(x0,'DisplayName','x0');
% hold on
for i = 1:k
    y = lambdas(i);
    cvx_begin quiet
        variable x(n)
        minimize( 0.5*norm(A*x-b, 2)  + y*norm(x, 1) )
    cvx_end
%     plot(x, 'DisplayName','$$lambda=$$' + num2str(y));
end
% hold off

%% Q1d
lambdas = logspace(-3, 3, 100);
k = length(lambdas);
f1_res = zeros(k, 1);
f2_res = zeros(k, 1);
signal_res = zeros(k, n);

for i = 1:k
    y = lambdas(i);
    cvx_begin quiet
        variable x(n)
        minimize( 0.5*norm(A*x-b, 2) + y*norm(x, 1) )
    cvx_end
    f1_res(i) = 0.5*norm(A*x - b);
    f2_res(i) = norm(x, 1);
    signal_res(i, :) = x;
end
plot(f1_res, f2_res);

%% Q1e
% load('hw4_1e.mat');
% lambdas = [1, 0.01, 10];
% k = length(lambdas);
% % TODO: Determine if I have construct diagnoal matrix myself
% % D = diag(ones(n-1, 1)) + diag(-ones(n-2), 1); 
% for i = 1:k
%     y = lambdas(i);
%     cvx_begin quiet
%         variable x(n)
%         minimize( 0.5*norm(A*x-b, 2)  + y*norm(D*x, 1) )
%     cvx_end
% end