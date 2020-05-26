function [C] = chi2_cost(s1,s2)


K = (size(s1,2)) ;
C = zeros(size(s1,1), size(s2,1)) ;

eps = 0.0001 ;

for i = 1:size(s1,1)
    for j = 1:size(s2,1)
        for k = 1:K
            C(i,j) = C(i,j) + ((s1(i,k)-s2(j,k))^2 /(s1(i,k)+s2(j,k)+eps)) ;
        end
    end
end
end

