function [ K, R, C ] = decompose(P)
    %decompose P into K, R and t 
    %K is the instrinsic camera matrix
    %R is the rotation matrix
    %C is the camera matrix

    M = P(:,1:3);
    
    C = null(P);
    
    %QR decomposition on inverse of M. 
    
    [R1 K1] = qr(inv(M));

    % invert both result matrices to get K and R
    K = inv(K1);
    K=K./K(3,3);
    R = inv(R1);    
    %[K R] = qr(M);
end