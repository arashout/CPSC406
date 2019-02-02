function [Y, rates, sigs] = efficient_frontier(r, Sig, num)

n = length(r);
rrange = return_range(r, Sig, num);

Y = zeros(n, num); 



for jj = 1:num
    
    cvx_begin quiet ;
        variable x1(n);
        minimize (quad_form(x1, Sig));
        subject to ;
            sum(x1) == 1;
            min(x1) >= 0;
            sum(r*x1) >= rrange(jj); % optimize subject to this anual return
        
    cvx_end;
    Y(:,jj) = x1;
    
end

rates = (r* Y)' ;
sigs = sqrt(diag(Y' * Sig * Y));