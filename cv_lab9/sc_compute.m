function [d] = sc_compute(X,nbBins_theta,nbBins_r,smallest_r,biggest_r)

X = X' ;
normalization = mean2(sqrt(dist2(X,X))) ;  

smallest_r = smallest_r*normalization ;
biggest_r = biggest_r*normalization ;

theta_size = 360/nbBins_theta ;

delta_r(1) = smallest_r;

for i = 1:nbBins_r
    delta_r(i+1) =  exp(log(smallest_r) + (log(biggest_r) - log(smallest_r))*i/nbBins_r) ;
end

d = zeros(max(size(X)), nbBins_theta*nbBins_r);

for i = 1:size(X,1)
    for j = 1:size(X,1)
        r = norm(X(i,:)-X(j,:)) ;
        if  (r < biggest_r && r > smallest_r)
            delta_x = X(j,1) - X(i,1) ;
            delta_y = X(j,2) - X(i,2) ;
            theta = rad2deg(atan2(delta_y,delta_x)) ;
            if theta<0
                theta = 360 + theta ;
            end
            theta_idx = ceil(theta/theta_size);
            if theta_idx == 0 
                theta_idx = 1 ;
            end
            r_idx = max(find(r >= delta_r)) ;
            d(i,theta_idx + (r_idx-1)*nbBins_theta) = d(i,theta_idx + (r_idx-1)*nbBins_theta) +1 ; 
        end
    end
end

