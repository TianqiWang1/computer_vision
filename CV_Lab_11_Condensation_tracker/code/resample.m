function [particles, particles_w] = resample(particles, particles_w)
% This function should resample the particles based on their weights and
% return these new particles along with their weights.
particles_w = max(particles_w,0);
particles_idx = randsample(1:size(particles,1),size(particles,1), true, particles_w);
particles = particles(particles_idx, :);
particles_w = particles_w(particles_idx, :);
particles_w = particles_w/sum(particles_w);

end