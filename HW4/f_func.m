function f_acc = f_func(x, C, d)
m = length(C);
f_acc = 0;
for i = 1:m
    f_acc = f_acc + (norm(x - C(:,i))^2 - d(i))^2;
end
end

