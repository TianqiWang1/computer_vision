function [matchingCostMatrix] = compute_matching_costs(objects,nbSamples)
N = max(size(objects)) ;
matchingCostMatrix = zeros(N) ;

for i = 1:N
    img1 = get_samples(objects(i).X,nbSamples);
    for j = 1:N
        img2 = get_samples(objects(j).X,nbSamples);
        matchingCostMatrix(i,j) = shape_matching(img1,img2,false);
    end
end       

end

