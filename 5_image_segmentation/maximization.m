% given the probability that each pixel falls in each class
% compute the new values of mu, var, and probability for each class

function [mu, var, alpha] = maximization(P, X)

K = size(P,2);
N = size(X,1);

% initilize the parameters

alpha = zeros(1,K);
mu = zeros(K,3);
var = zeros(3,3,K);

for k = 1:K
     alpha(k) = sum(P(:,k))/N;
     mu(k,:) = sum(X.*repmat(P(:,k),[1,3]))/sum(P(:,k));
     
     for l = 1:N
        var(:,:,k) = var(:,:,k) + P(l,k)*((X(l,:)-mu(k,:))'*(X(l,:)-mu(k,:)));
     end
    var(:,:,k) = var(:,:,k)/(alpha(k)*N);
end

alpha = alpha/sum(alpha);

end