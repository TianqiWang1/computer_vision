% X: matrix of size L*n, the discrete samples of the density function
% x1: given pixel
% r: radius of the window

function [peak] = find_peak(X, x1, r)

L = size(X,1);
peak_prev = x1;
threshold = 10;
shift = threshold+1;

% terminate when the distance between old and new points reaches the threshold
while shift > threshold
    % compute the distance from every pixel to old point
    dist =  sqrt(sum(((X-repmat(peak_prev,[L,1])).^2),2));
    % find points within the window to the peak
    window = X(dist < r,:);
    % new point would be the mean of the points in window
    peak = mean(window,1);
    % compute the distance from the old point to the new point
    shift = norm(peak_prev-peak);
    % new point becomes the old point
    peak_prev = peak;
end

end