function [rrange] = return_range_plot(r,Sig,num)

n = length(r);

cvx_begin
    variable x1(n);
    maximize ( r * x1  );
    subject to 
        sum(x1) == 1;
        min(x1) >= 0;
        
cvx_end

maxr = x1

cvx_begin
    variable x2(n) ;
    minimize (quad_form(x2, Sig));
    subject to 
        %sum(x2) == 1;
        ones(1,n) * x2 ==1;
        min(x2) >= 0;
        
        %r*x2 >= 0.13
        
        
cvx_end

minv = x2
%===================================================
%plot return @minv allocaiton over the year
rmiv = X * minv
plot(rmiv);

% =================================================
%return rrange and vrange and plot the relationship between them
for i = 1: n
    range_matrix (i,:) = linspace(maxr(i),minv(i),num);
end

rrange = r*range_matrix;
vrange = diag(range_matrix' * Sig * range_matrix); % diagnal one represent the weight*sig*weight'

plot(vrange',rrange)
end
%===================================================
