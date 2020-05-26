function [newpts, T] = normalize(pts)
% pts is a matrix of shape 3*n

    pts(4,:) = 1;
    
    c = mean(pts(1:3,:),2);           
    newp(1,:) = pts(1,:)-c(1); 
    newp(2,:) = pts(2,:)-c(2);
    newp(3,:) = pts(3,:)-c(3);
    
    dist = sqrt(newp(1,:).^2 + newp(2,:).^2 + newp(3,:).^2);
    meandist = mean(dist(:)); 
    
    scale = sqrt(3)/meandist;
    
    T = [scale   0      0   -scale*c(1);
         0     scale    0   -scale*c(2);
         0       0    scale -scale*c(3);
         0       0      0       1      ];
    
    newpts = T*pts;