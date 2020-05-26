function meanState = estimate( particles, particles_w )
% This function should estimate the mean state given the particles and
% their weights
    meanState = zeros(1,size(particles,2));
    for i = 1:size(particles,2)
       meanState(i) = dot(particles_w,particles(:,i));
    end
    
end

