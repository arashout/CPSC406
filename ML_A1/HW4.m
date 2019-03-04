% clear all
%% Part 1 - Retrieval
load("mnist.mat")
% 
% figure(1)
% clf
% i = 1;
% imshow(reshape(trainX(i,:),28,28)')
% title(trainY(i))

%% Part 2 - Pre-processing
idx = trainY == 4 | trainY == 9;
Atrain = double(trainX(idx,:));
btrain = double(trainY(idx))';
n = size(Atrain, 2);
mtrain = size(Atrain, 1);
btrain(btrain==4)=1;
btrain(btrain==9)=-1;   

idx_test = testY == 4 | testY == 9;
Atest = double(testX(idx_test,:));
btest = double(testY(idx_test))';
mtest = size(Atest, 1);
% Turn labels into +1 -1
btest(btest==4)=1;
btest(btest==9)=-1;   

% Normalization
Amean = mean(Atrain,1);
Atrain = Atrain - ones(mtrain,1)*Amean;
Astd = std(Atrain,1);
Atrain = Atrain ./ max(ones(mtrain,1)*Astd,1);

Atest = Atest - ones(mtest,1)*Amean;
Atest = Atest ./ max(ones(mtest,1)*Astd, 1);

%% Part 3 - Linear Regression
x = Atrain \ btrain;

train_loss = norm(Atrain*x - btrain, 2)
test_loss = norm(Atest*x - btest, 2)

C = @(z) (z > 0)*2 - 1;
I = @(x,y) x ~= y;
misclass_rate = @(A,b,x) sum(I(C(A*x), b)/length(b));
train_misclass_rate = misclass_rate(Atrain, btrain, x)
test_misclass_rate = misclass_rate(Atest, btest, x)

btrain = (btrain+1)/2;

%% Part 4 - Logistic Regression
sig = @(x) 1./(1+exp(-x));
f = @(A,b,x) @(x) sum(b .* log(sig(A*x)) + (1-b) .* log(1 - sig(A*x)) ); % TODO: Keep getting NAN
g = @(A,b,x) @(x) A'*(sig(b - A*x));
l = @(A,b, x) @(x) norm(A*x - b, 2);
x0 = zeros(n, 1);

% Gradient Descent - ODDLY enough the 1/mtrain step-size seems too big and
% causes zig-zagging
[x, trace] = gradient_descent(g(Atrain, btrain), l(Atrain, btrain), x0, 1000, 1/mtrain*0.001); 
train_misclass_rate_gd = misclass_rate(Atrain, btrain, x)
test_misclass_rate_gd = misclass_rate(Atest, btest, x)
figure(1)
plot(trace, '.')
hold on
% Backtracking Line Search 
% TODO: this is garbage and doesn't work properly... How to fix?
% [x, trace] = gradient_descent_btls(f(Atrain, btrain), g(Atrain, btrain), l(Atrain, btrain), x0, 1000, 1, 0.5, 0.5); 
% train_misclass_rate_gd_btls = misclass_rate(Atrain, btrain, x)
% test_misclass_rate_gd_btls = misclass_rate(Atest, btest, x)
% plot(trace, 'g.')
hold off

figure(2)
prices = [train_misclass_rate_gd, test_misclass_rate_gd, train_misclass_rate_gd, test_misclass_rate_gd];
bar(prices)
title('Misclassification rates')
% TODO: How is it possible to perform better on the test set?
set(gca,'xticklabel',{'Train GD','Test GD','Train GD-BS', 'Test GD-BS'});