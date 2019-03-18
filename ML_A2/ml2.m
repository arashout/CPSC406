clear all
close all

%% Setup
load embeddings

fid = fopen('wordlist.txt');
data = textscan(fid,'%s');
fclose(fid);
words = data{1};
m = length(words);
embeddings = embeddings(1:m, :);

%% Map to 2D space
[U,S,V] = svds(embeddings,2);
emb2d = U*sqrt(S);

%% Initial Visualization

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
% text(emb2d(toplot,1),emb2d(toplot,2), words(toplot))
% hold off

%% K-means
n = m;
k = 1000;
d = 50;
X = embeddings;
P = randomP(n, k);
a = min(X(:));
b = max(X(:));
C = a + (b-a).*rand(k,d);

% figure(1)
pf = @(h, C, P) plotFunc(h, X, C, P, 0); % Putting a zero means do not plot
[C, P] = k_means(X, k, 100, C, P, pf);

%% 3. Analysis
words = data{1};
topN = 100;
[M, ind] = maxk(sum(P), topN);
word_clusters = {};
for c = ind
    word_ind = find(P(:, c));
    word_cluster = words(word_ind);
    word_clusters{end+1} = word_cluster;
end

close all

