function [Class] = nn_classify(matchingCostVector, trainClasses, K)

[~, Idx] = sort(matchingCostVector);
idx = Idx(1:K);

arr = {};
for i = numel(idx)
    arr{end+1} = trainClasses{idx(i)};
end
y = unique(arr);

n = zeros(length(y), 1);

for iy = 1:length(y)
  n(iy) = length(find(strcmp(y{iy}, arr)));
end

[~, itemp] = max(n);
Class = y(itemp);


