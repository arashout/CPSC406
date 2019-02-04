function [Y, rates, sigs] = efficient_frontier(r, Sig, num)

n = length(r);
rrange = return_range(r, Sig, num);

Y = zeros(n, num); 

for jj = 1:num
    current_rate_of_return = rrange(jj);
    cvx_begin quiet ;
        variable x1(n);
        minimize (quad_form(x1, Sig));
        subject to ;
            sum(x1) == 1;
            min(x1) >= 0;
            sum(r*x1) >= current_rate_of_return; % optimize subject to this annual return
    cvx_end;
    
    Y(:,jj) = x1;
end

rates = (r* Y)' ;
sigs = sqrt(diag(Y' * Sig * Y));