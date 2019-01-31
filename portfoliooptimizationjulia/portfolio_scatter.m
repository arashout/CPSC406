function h = portfolio_scatter(r, Sig, num)
% num == Number of iterations for monte carlo simulation
h = figure;
randmu  = zeros(num,1);
randSig = zeros(num,1);

% For each portfolio generated a random allocation
numStocks = 5;
n = length(r);

for ii=1:num
        % TODO: Double with smaller numbers
        randomStocks = randi([1 19],5,1);
        rn = rand(numStocks, 1);
        randomAllocation = rn/sum(rn);
        expectedReturn = r(randomStocks')*randomAllocation;
        randmu(ii) = expectedReturn;
        
        expectedRisk = 0;
        for i=1:numStocks
            si = randomStocks(i); % ith Stock Index
            expectedRisk = expectedRisk + r(si)^2 * Sig(si, si);
            for j=1:numStocks
                if j ~= i
                    sj = randomStocks(i); %jth Stock Index
                    expectedRisk = expectedRisk + r(si) * r(sj) * Sig(si, sj);
                end
            end
        end
        
        randSig(ii) = expectedRisk;
end
scatter(randSig, randmu, 5)
xlabel('Std. Dev.')
ylabel('Expected Rate of Return')

end