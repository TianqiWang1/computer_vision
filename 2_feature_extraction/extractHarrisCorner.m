% extract harris corner
%
% Input:
%   img           - n x m gray scale image
%   thresh        - scalar value to threshold corner strength
%   
% Output:
%   corners       - 2 x k matrix storing the keypoint coordinates
%   H             - n x m gray scale image storing the corner strength

function [corners, H] = extractHarrisCorner(img, thresh)

%initialize H
n = size(img,1);
m = size(img,2);
H = zeros(n,m);

%compute intensity gradients in x- and y- direction
[Ix,Iy] = imgradient(img);

%blur image to get rid of noise
f = fspecial('gaussian');
Ix2 = imfilter(Ix.^2,f);
Iy2 = imfilter(Iy.^2,f);
Ixy = imfilter(Ix.*Iy,f);

%compute harris matrix
for x=2:n-2
    for y=2:m-2
        Ix2_matrix = Ix2(x-1:x+1,y-1:y+1);
        Ix2_sum = sum(Ix2_matrix(:));
        Iy2_matrix = Iy2(x-1:x+1,y-1:y+1);
        Iy2_sum = sum(Iy2_matrix(:));
        Ixy_matrix = Ixy(x-1:x+1,y-1:y+1);
        Ixy_sum = sum(Ixy_matrix(:));
        Matrix = [Ix2_sum, Ixy_sum; 
                  Ixy_sum, Iy2_sum];
        K1 = det(Matrix)/trace(Matrix);
        H(x,y) = K1;
    end
end

%threshold the response image
% set threshold of 'cornerness' to 5 times average score
avg_r = mean(mean(H));

%Apply Non-Maximum-Suppression in a 3 pixel radius
%to the pixels whose response is over a threshold. 
%Store the pixel coordinates of the resulting keypoints.

window_size = 3;

% apply 3X3 maximum filter
mx = ordfilt2(H,window_size^2,ones(window_size,window_size)); 

% Find maxima, threshold
H_points = (H==mx) & (H>thresh);

% Find rows and columns of keypoints. 
[row,column] = find(H_points);

corners = [row'; column'];

end