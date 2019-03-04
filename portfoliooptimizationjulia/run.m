%% HW3 - Portfolio Optimization
%
% Guowei Huang - 25911158
% Arash Outadi - 35898139
%
% *Supplementary files:*
sup_code = [
"load_stocks"
"load_stock"
"portfolio_scatter"
"meancov"
"return_range"
"efficient_frontier"
"market_portfolio"
];
for i = 1:length(sup_code)
    publish(sup_code(i), 'format', 'pdf', 'evalCode', false);
end

clear all
close all

warning('off', 'MATLAB:table:ModifiedAndSavedVarnames');
% rng(1); % Random seed for testing\debugging 

%% Q1 
[X, dates, names] = load_stocks("data", "2017-01-03","2017-12-29");
disp_stocks(X, dates, names);
[r, Sig] = meancov(X);
h = portfolio_scatter(r, Sig, 1000);

%% Q2
num = 12;
[Y,rates,sigs]= efficient_frontier(r,Sig,num);
figure(h); 
hold on; 
title("Efficient frontier");
plot(sigs, rates, 'ro-');
ylim([0 0.5]); 
xlim([0 max(sigs)]);

%% Q3
f = 0.03;
r_= [r, f]; % add risk free return
Sig_ = [Sig , zeros(19,1)] ;
Sig_ = [Sig_; zeros(1,20)]; % build risk free Sig
[Y_,rates_,sigs_]=efficient_frontier(r_,Sig_,num); %calculate coresponding efficient frontier
plot(sigs_,rates_,'go-');
title("Efficient frontier with risk-free stock")
market_x = market_portfolio(f,r',Sig);
annotation(h,'line',[0.128070175438597 0.910526315789474],...
    [0.15852380952381 0.928571428571429],'LineStyle','--');
%%
% *Q3 - Meaning of linear part*
%
% The linear half-line (Before the tangent point) represents the new
% extended region of the efficient frontier thanks to the addition of the
% risk free stock. This stock has no variance by definition thus including
% in the portfolio results in a linear gain in rate of return