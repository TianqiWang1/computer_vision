function [xyn, XYZn, T, U] = normalization(xy, XYZ)

%data normalization
% to ensure homogeneous coordinates have scale of 1
xy(1,:) = xy(1,:)./xy(3,:);
xy(2,:) = xy(2,:)./xy(3,:);
xy(3,:) = 1;

XYZ(1,:) = XYZ(1,:)./XYZ(4,:);
XYZ(2,:) = XYZ(2,:)./XYZ(4,:);
XYZ(3,:) = XYZ(3,:)./XYZ(4,:);
XYZ(4,:) = 1;

%scale
%average dist from the origin is sqrt(2) for image points
%and sqrt(3) for object points
xyc(1,:) = xy(1,:)-mean(xy(1,:)); 
xyc(2,:) = xy(2,:)-mean(xy(2,:));
   
XYZc(1,:) = XYZ(1,:)-mean(XYZ(1,:)); 
XYZc(2,:) = XYZ(2,:)-mean(XYZ(2,:));
XYZc(3,:) = XYZ(3,:)-mean(XYZ(3,:));
    
%create T and U transformation matrices
xy_dist = sqrt(xyc(1,:).^2 + xyc(2,:).^2);   
xy_meandist = mean(xy_dist(:));
Tscale = sqrt(2)/xy_meandist;

XYZ_dist = sqrt(XYZc(1,:).^2 + XYZc(2,:).^2 + XYZc(3,:).^2);
XYZ_meandist = mean(XYZ_dist(:));
Uscale = sqrt(3)/XYZ_meandist;

%create T and U transformation matrices
T = [Tscale   0   -Tscale*mean(xy(1,:))
     0     Tscale -Tscale*mean(xy(2,:))
     0       0      1      ];

U = [Uscale  0     0      -Uscale*mean(XYZ(1,:))
     0     Uscale  0      -Uscale*mean(XYZ(2,:))
     0       0   Uscale   -Uscale*mean(XYZ(3,:))
     0       0     0        1    ];

%and normalize the points according to the transformations
xyn = T*xy;
XYZn = U*XYZ;

end
