[X, dates, names] = load_stocks("data", "2017-05-01","2017-12-31");
disp_stocks(X, dates, names);
[means, C] = meancov(X);
h = portfolio_scatter(X, C, 1000);