function [k, b] = ransacLine(data, iter, threshold)
% data: a 2xn dataset with #n data points
% iter: the number of iterations
% threshold: the threshold of the distances between points and the fitting line

num_pts = size(data,2); % Total number of points
best_inliers = 0;       % Best fitting line with largest number of inliers
k=0; b=0;                % parameters for best fitting line

for i=1:iter
    % Randomly select 2 points and fit line to these
    % Tip: Matlab command randperm is useful here 
    
    idx = randperm(num_pts, 2);
    p1 = data(:,idx(1));
    p2 = data(:,idx(2));
    % Model is y = k*x + b
    k_curr = (p1(2)-p2(2))/(p1(1)-p2(1));
    b_curr = p1(2) - k*p1(1);
    
    % Compute the distances between all points with the fitting line   
    % Compute the inliers with distances smaller than the threshold
    % Update the number of inliers and fitting model if better model is found
    inliers = 0;
    
    for j = 1:num_pts 
        pt = data(:,j);
        error = sqr_error(k_curr,b_curr,pt);
        if (error < threshold)
            inliers = inliers + 1;
        end
    end
    
    if (inliers > best_inliers)
        best_inliers = inliers;
        k = k_curr;
        b = b_curr;
    end
    
end


end
