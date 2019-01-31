clear all
close all

warning('off', 'MATLAB:table:ModifiedAndSavedVarnames');

rng(1);
[X, dates, names] = load_stocks("data", "2017-05-01","2017-12-31");
% [X1, dates1, names1] = load_stocks_soln('data', "2017-05-01","2017-12-31");
disp_stocks(X, dates, names);
[means, C] = meancov(X);
h = portfolio_scatter(means, C, 1000);