% Compute the fundamental matrix using the eight point algorithm
% Input
% 	x1s, x2s 	Point correspondences
%
% Output
% 	Fh 			Fundamental matrix with the det F = 0 constraint
% 	F 			Initial fundamental matrix obtained from the eight point algorithm
%
function [Fh, F] = fundamentalMatrix(x1s, x2s)

[nx1s,T1] = normalizePoints2d(x1s);
[nx2s,T2] = normalizePoints2d(x2s);


A = ones(10,9);
u1 = nx1s(1,1:10);
v1 = nx1s(2,1:10);
u2 = nx2s(1,1:10);
v2 = nx2s(2,1:10);
    
A(:,1) = u2.*u1;
A(:,2) = u2.*v1;
A(:,3) = u2;
A(:,4) = u1.*v2;
A(:,5) = v1.*v2;
A(:,6) = v2;
A(:,7) = u1;
A(:,8) = v1;

% AF = 0
% do SVD to A and F is the last vector of V
[Q,S,V] = svd(A);
h = V(:,end);
F = reshape(h,3,3)';

% project to cloest signuar matrix using SVD
% impose the constraint that det(F)=0
[Q1, S1, V1] = svd(F);
S1(3,3) = 0;
Fh = Q1*S1*V1';

% denomarlize 
Fh = T2'* Fh * T1;
F = T2'* F * T1;

end