function particles = propagate(particles,sizeFrame, params)

% propagates particles given system prediction model and system model noise
% represented by params.model, params.sigma_position and
% params.sigma_velovity. Use the parameter sizeFrame to make sure that the
% center of particles lies inside the frame

if (params.model == 1) % constant velocity
    A = [1, 0, 1, 0;
         0, 1, 0, 1;
         0, 0, 1, 0;
         0, 0, 0, 1];
     
    particles = (A*particles' + [normrnd(0,params.sigma_position,[size(particles,1),2]),...
                                 normrnd(0,params.sigma_velocity,[size(particles,1),2])]')';
else % no motion
    A = eye(2);
    particles = (A*particles' + normrnd(0,params.sigma_position,size(particles))')';
                     
end

particles(:,1) = min(particles(:,1),sizeFrame(2));
particles(:,1) = max(particles(:,1),0);
particles(:,2) = min(particles(:,2),sizeFrame(1));
particles(:,2) = max(particles(:,2),0);

end

