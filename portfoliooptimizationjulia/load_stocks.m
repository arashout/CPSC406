function [X, dates, names] = load_stocks(dirname, startdate, enddate)
% Convert strings to datetime objects for comparisions in load_stock.m
startdate = datetime(startdate,'InputFormat','yyyy-MM-dd');
enddate = datetime(enddate,'InputFormat','yyyy-MM-dd');

files = dir(dirname) ;
datafiles = [];
for i = 1:length(files)
    file = files(i);
    if endsWith(file.name, ".csv")
        datafiles = [datafiles; file];
    end
end

n = length(datafiles); % n stocks
X = []; % Annoying that we do not know the number of days in advance...

names = cell(n, 1);
for i = 1:n
    file = datafiles(i);
    names(i) = {file.name(1:end-4)}; % Need curly brackets to convert to cell... Stupid..
    [roi, dates] = load_stock(fullfile(file.folder, file.name), startdate, enddate);
    X = [X, roi]; % Concanate new vector to matrix
end

end
