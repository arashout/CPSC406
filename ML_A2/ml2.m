clear all
close all

load embeddings

fid = fopen('wordlist.txt');
data = textscan(fid,'%s');
fclose(fid);
words = data{1};
m = length(words);
embeddings = embeddings(1:m, :);

[U,S,V] = svds(embeddings,2);
emb2d = U*sqrt(S);

% figure(1)
% clf
% plot(emb2d(:,1),emb2d(:,2),'linestyle','none')
% hold on
% text(emb2d(:,1),emb2d(:,2), words)
% hold off
% 
% fid = fopen('plotwords.txt');
% data = textscan(fid,'%s');
% fclose(fid);
% plotwords = data{1};
% toplot = false(n,1); %n is the number of words
% for k = 1:n
% word = words{k};
% toplot(k) = sum(strcmpi(word,plotwords))>0;
% end
% figure(1)
% clf
% plot(emb2d(toplot,1),emb2d(toplot,2),'linestyle','none')
% hold on
% % TODO: Fix this?
% text(emb2d(toplot,1),emb2d(toplot,2), words(toplot))
% hold off

n = m;
k = 500;
X = emb2d;
figure(1)
[C, P] = k_means(X, k, 10);
M = repmat([1:1:k],n, 1);
clusters = sum(M.*P, 2);
hold on
scatter(X(:, 1), X(:, 2), 20, clusters);
scatter(C(:,1), C(:,2), 'filled');
hold off
colormap(jet(5))


