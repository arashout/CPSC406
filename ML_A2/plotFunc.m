function [h] = plotFunc(h, X, C, P, show)
    % Helper function to plot on each iteration of k-means
    if show == 0
        return
    end
    
    [n, ~] = size(X);
    [k, ~] = size(C);
    M = repmat(1:1:k,n, 1);
    clusters = sum(M.*P, 2);
    if h ~= 0
        delete(h)
        h = scatter(C(:,1), C(:,2), 'ko', 'filled');
        scatter(X(:, 1), X(:, 2), 20, clusters);
        pause(1);
    else
        h = scatter(C(:,1), C(:,2), 'ko', 'filled');
        scatter(X(:, 1), X(:, 2), 20, clusters);
    end
    colormap(jet(5))
end