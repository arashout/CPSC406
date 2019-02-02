
m = 20; n = 10; p = 4; var = 3,
A = randn(m,n); b = randn(m,var);
C = randn(p,n); d = randn(p,var); e = rand;
cvx_begin
    variable x(n,var)
    minimize( norm( A * x - b, 2 ) )
    subject to
        C * x == d
        norm( x, Inf ) <= e
cvx_end
