function h = portfolio_scatter(r, Sig, num)
h = figure;
randmu  = zeros(num,1);
randSig = zeros(num,1);

% For each portfolio generated a random allocation
numStocks = 5;
n = length(r);

for ii=1:num
        randomStocks = randperm(19,5); %randperm is used to avoid overwriting same stock
        rn = rand(numStocks, 1);
        randomAllocation = rn/sum(rn);
        weight = zeros(size(r));
        weight(randomStocks') = randomAllocation; % the selected stocks have some allocation, unselected stocks will be 0
        expectedReturn = r* weight';
        expectedRisk = sqrt(weight * Sig * weight'); % From modern portfolio theory page
        randSig(ii) = expectedRisk;
        randmu(ii) = expectedReturn;
end
scatter(randSig, randmu, 5);
title("Random portfolios: Risk vs ROI");
xlabel('Risk (Std. Dev.)');
ylabel('Expected Rate of Return');
end