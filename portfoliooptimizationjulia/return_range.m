function [rrange] = return_range(r,Sig,num)

n = length(r);

cvx_begin quiet ;
    variable x1(n);
    maximize ( r * x1  );
    subject to ;
        sum(x1) == 1;
        min(x1) >= 0;
        
cvx_end;

maxr = x1;

cvx_begin quiet;
    variable x2(n) ;
    minimize (quad_form(x2, Sig));
    subject to ;
        %sum(x2) == 1;
        ones(1,n) * x2 ==1;
        min(x2) >= 0;
        
        %r*x2 >= 0.13
        
        
cvx_end;

minv = x2;

rrange = linspace(r*minv, r*maxr, num);
