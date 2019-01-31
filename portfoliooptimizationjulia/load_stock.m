function [r, dates] = load_stock(filename, startdate, enddate)
 
A = readtable(filename);

dates = table2array(A(:,1));
p = table2array(A(:,6));
% Filter out the dates not between start and end date
index_array = find(dates >= startdate & dates <= enddate);
dates = dates(index_array);
p = p(index_array);

% Compute rate of return
r = (p - p(1))/p(1);

end