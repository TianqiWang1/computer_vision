% Decompose the essential matrix
% Return P = [R|t] which relates the two views
% You will need the point correspondences to find the correct solution for P
function P = decomposeE(E, x1, x2)

[U,~,V] = svd(E);
W = [0 -1 0; 1 0 0; 0 0 1];

R1 = U * W * V';
R2 = U * W' * V';

R1 = R1*det(R1);
R2 = R2*det(R2);


t1 = U(:,end);
t1 = t1/norm(t1);
t2 = -t1;

P0 = [eye(3),zeros(3,1)];
P1 = [R1, t1];
P2 = [R1, t2];
P3 = [R2, t1];
P4 = [R2, t2];
Ps = {P1, P2, P3, P4};

for i = 1:4
    P = Ps{i}; 
    [X,~] = linearTriangulation(P0, x1, P, x2);
    PX = P*X;
    if min(X(3,:)) > 0 && min(PX(3,:)) > 0
        figure(i);
        scatter3(X(1,:), X(2,:), X(3,:));
        hold on;
        showCameras({[P0;0,0,0,1],[P;0,0,0,1]},i);
    end
end    
    

end