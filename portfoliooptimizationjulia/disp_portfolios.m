function h = disp_portfolios(Y, rates, sigs, names)

[n, num] = size(Y);


%% Print table
table_width = 12 + 7*num;
fprintf('\n');
fprintf([repmat('=',1,table_width),'\n']);
fmt = ['%12s', repmat('%7.0f',1,num), '\n'];
fprintf(fmt, 'Portfolio:', 1:num);
fprintf([repmat('-',1,table_width),'\n']);
for ii=1:n
    fmt = ['%6d%6s', repmat('%7.1f',1,num), '\n'];
    fprintf(fmt, ii, names{ii}, 100*Y(ii,:));
end
fprintf([repmat('-',1,table_width),'\n']);
fmt = ['%12s', repmat('%7.1f',1,num), '\n'];
fprintf(fmt, 'E[Return] =', 100*rates);
fprintf(fmt, 'Std. Dev. =', 100*sigs);
fprintf([repmat('=',1,table_width),'\n']);
fprintf('\n');


%% Display pie charts
map = colormap('jet');
stockColors = map(round(linspace(1, 64, n)), :);

% Determine number of subplot rows and columns
cols = max(factor(num));
rows = num/cols;

h = figure;
for ii=1:num
    x = Y(:,ii);  
    inds = find(x>1e-3); 
    subplot(rows, cols, ii);
    h = pie(x(inds), names(inds)); 
    title( ...
        sprintf(...
        'Portfolio %d\nE[Return] = %.1f%%,  Std. Dev. = %.1f%%', ...
        ii, 100*rates(ii), 100*sigs(ii)) );
    
    % Change the pie colors
    for jj=1:2:length(h)
        % get name of the stock for pie slice label
        v = get(h(jj+1));  stockName = v.String;
        % find the index number of the stock
        stockInd = strcmp(stockName, names);
        % change the FaceColor property of the pie slice
        set(h(jj), 'FaceColor', stockColors(stockInd, :));
    end
    
end
