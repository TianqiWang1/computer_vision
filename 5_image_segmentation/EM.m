function [map peak] = EM(img)

% use function generate_mu to initialize mus
% use function generate_cov to initialize covariances

% iterate between maximization and expectation
% use function maximization
% use function expectation

    % create X matrix
    img = double(img);
    [h,w,~] = size(img);
    X = reshape(img,[h * w,3]);
    [Xn,T] = normalize(X');
    Xn = Xn(1:3,:)';
    
    % initialize the parameters
    threshold = 0.01;
    delta_mu = threshold+1;
    %K = 3;
    %K = 4;
    K = 5;
    
    % initialize mu and var
    % to random values within the range of L*a*b values
    LMax = max(Xn(:,1)); 
    Lmin = min(Xn(:,1));
    aMax = max(Xn(:,2));
    amin = min(Xn(:,2));
    bMax = max(Xn(:,3)); 
    bmin = min(Xn(:,3));
    % mu: K*3 matrix
    mu_e = generate_mu(LMax,Lmin,aMax,amin,bMax,bmin,K);
    % var: 3*3*K matrix
    var_e = generate_cov(LMax,Lmin,aMax,amin,bMax,bmin,K);
    
    % initialize the cluste probabiltiy according to uniform distribution
    alpha_e = ones(1,K)/K;
    
    % terminate iteration when the delta mu reaches the threshold
    while delta_mu > threshold
        % expectation
        P = expectation(mu_e,var_e,alpha_e,Xn);
        % maximization
        [mu_m, var_m, alpha_m] = maximization(P, Xn);
        delta_mu = norm(mu_e(:)-mu_m(:));
        % iterate
        mu_e = mu_m;
        var_e = var_m;
        alpha_e = alpha_m;
    end
    
    mu_e
    var_e
    alpha_e
    
    % compute the map and the peak
    [~,idx] = max(P,[],2);
    map = reshape(idx, h, w);
    peak = mu_e;
   
    % denormalize the peak
    peakh = [peak';ones(1,size(peak,1))];
    peaku = T \ peakh;
    peak = peaku(1:3,:)';

end