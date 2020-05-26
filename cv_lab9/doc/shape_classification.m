function classificationAccuracy = shape_classification(k)

temp = load('dataset.mat');
objects = temp.objects;

nbObjects = length(objects);
nbSamples = 100;

matchingCostMatrix = compute_matching_costs(objects,nbSamples);

for o1 = 1:length(objects)
    matchingCostMatrix(o1,o1) = inf; 
end

    allClasses = {objects(:).class};

    hits = 0;
    for o1 = 1:length(objects)        
        testClass = nn_classify(matchingCostMatrix(o1,:),allClasses,k);   
        if strcmpi(allClasses{o1},testClass)        
            hits = hits + 1;                
        end
    end
    fprintf('done\ntrue positives: %d/%d\n', hits, nbObjects);

    classificationAccuracy = hits/nbObjects;
end
