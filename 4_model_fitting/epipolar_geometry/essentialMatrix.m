% Compute the essential matrix using the eight point algorithm
% Input
% 	x1s, x2s 	Point correspondences 3xn matrices
%
% Output
% 	Eh 			Essential matrix with the det F = 0 constraint and the constraint that the first two singular values are equal
% 	E 			Initial essential matrix obtained from the eight point algorithm
%

function [Eh, E] = essentialMatrix(x1s, x2s)

% normalize
[nx1s,T1] = normalizePoints2d(x1s);
[nx2s,T2] = normalizePoints2d(x2s);

% construct A, s.t. AE = 0
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

% SVD(A)
[Q,S,V] = svd(A);
h = V(:,end);
E = reshape(h,3,3)';

% for Eh,
[Q1,S1,V1] = svd(E);
% impose the constraint that the first two singular values are equal
s = (S1(1,1) + S1(2,2))/2;
S1(1,1) = s;
S1(2,2) = s;
% and the constraint that det(S) = 0
S1(3,3) = 0;

% reconstruct Eh
Eh = Q1 * S1 * V1';

% denormalize
E = T2' * E * T1;
Eh = T2' * Eh * T1;
    
end
