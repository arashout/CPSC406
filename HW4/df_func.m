function df_vec = df_func(x, C, d)
m = length(C);
n = length(x);
df_vec = zeros(n, 1);
for j = 1:n
    df_acc = 0;
    for i = 1:m
        df_acc = df_acc + 4*(norm(x-C(:,i))^2 - d(i)^2)*(x(j) - C(j,i));
    end
    df_vec(j) = df_acc;
end
end

