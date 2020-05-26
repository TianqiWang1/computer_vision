function [w_x, w_y, E] = tps_model(X,Y,lambda)

N = size(X,1) ;
r2 = dist2(X,X) ;
K = r2.*log(r2);
K(isnan(K)) = 0 ;
P = [ones(N,1), X] ;
A = [K+lambda*eye(N), P; P', zeros(3,3)];
vx = Y(:,1) ; vy = Y(:,2) ;
bx = [vx;0;0;0] ; by = [vy;0;0;0] ;

w_x = A\bx ;
w_y = A\by ;

E = w_x(1:N)'*K*w_x(1:N) + w_y(1:N)'*K*w_y(1:N);

end

