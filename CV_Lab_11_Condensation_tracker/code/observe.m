function particles_w = observe(particles,frame,H,W,hist_bin,hist_target,sigma_observe)

% This function should make observations i.e. compute for all particles its
% color histogram describing the bounding box defined by the center of the
% particle and W and H. These observations should be used to update the
% weights particles_w based on chi-square distance between the particle
% color histogram and the target histogram.

particles_w = zeros(size(particles,1),1);

for i = 1:size(particles,1)
    xMin = particles(i,1) - W/2;
    xMax = particles(i,1) + W/2;
    yMin = particles(i,2) - H/2;
    yMax = particles(i,2) + H/2;
    
    color_hist = color_histogram(xMin,yMin,xMax,yMax,frame,hist_bin);
    dist = chi2_cost(color_hist, hist_target);
    particles_w(i) = 1/(sqrt(2*pi)*sigma_observe)*exp(-(dist^2)/(2*sigma_observe^2));
    
end

particles_w = particles_w/sum(particles_w);

end

