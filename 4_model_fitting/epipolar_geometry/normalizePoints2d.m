% Normalization of 2d-pts
% Inputs: 
%           xs = 2d points
% Outputs:
%           nxs = normalized points
%           T = 3x3 normalization matrix
%               (s.t. nx=T*x when x is in homogenous coords)
function [nxs, T] = normalizePoints2d(xs)

% shift mean
means = mean(xs,2);
xs_c(1,:) = xs(1,:) - means(1);
xs_c(2,:) = xs(2,:) - means(2);

% scale
norms = sqrt(xs_c(1,:).^2 + xs_c(2,:).^2);
mean_norms = mean(norms(:));
Tscale = sqrt(2)/mean_norms;

% create T transformation matrices

T = [Tscale   0   -Tscale*mean(xs(1,:))
     0     Tscale -Tscale*mean(xs(2,:))
     0       0      1      ];

nxs = T*xs;

end
