function h = disp_stocks(X, dates, names)

n = size(X,2);

% Determine number of subplot rows and columns
cols = max(factor(n));
rows = n/cols;

h = figure;
for ii=1:n
%     subplot(rows, cols, ii);
    
    plot(datenum(dates), X(:,ii)); hold on
    plot(datenum(dates), zeros(size(dates)), 'k');
    
    title(names{ii});
    datetick('x','mmmyy')
    ylabel('Rate of return')
    ylim([-1.0 1.0])
end
legend(names)
drawnow();