% Generate initial values for the K
% covariance matrices

% diagonal matrix corresponds to the range in L*a*b space

function cov = generate_cov(LMax,Lmin,aMax,amin,bMax,bmin, K)

cov = zeros(3,3,K);

range = [LMax-Lmin,aMax-amin,bMax-bmin];
for k = 1:K
    cov(:,:,k) = diag(range);
end

end