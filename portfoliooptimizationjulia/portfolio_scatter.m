function h = portfolio_scatter(r, Sig, num)
% num == Number of portfolios:
% A portfolio consists 
h = figure;
randmu  = zeros(num,1);
randSig = zeros(num,1);
for ii=1:num
    ...
end
scatter(randSig, randmu, 5)
xlabel('Std. Dev.')
ylabel('Expected Rate of Return')