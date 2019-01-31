function [r, Sig] = meancov(X)
 
r = mean(X);
Sig = cov(X);

end