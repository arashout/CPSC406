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
        %randomStocks = randi([1 n],5,1);
        randomStocks = randperm(19,5);
        rn = rand(numStocks, 1);
        randomAllocation = rn/sum(rn);
        weight = zeros(size(r));
        weight(randomStocks') = randomAllocation; % the selected stocks have some allocation, unselected stocks will be 0
        %each element of randomstocks must be different, otherwise rewrite
        expectedReturn = r* weight';
        expectedRisk = sqrt(weight * Sig * weight'); % see the pdf i sent you
       %{
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
        %}
        weight_m(:,ii) = weight';
        randSig(ii) = expectedRisk;
        randmu(ii) = expectedReturn;
end
scatter(randSig, randmu, 5)
xlabel('Std. Dev.')
ylabel('Expected Rate of Return')
end