function [in1, in2, out1, out2, m, F] = ransac8pF(x1, x2, threshold)

iter = 1000;
num = size(x1, 2);
x1(3,:) = ones(1,num);
x2(3,:) = ones(1,num);
bestRes = 0;
p = 0.99;
n = intmax;
i = 0;


while (i < n)
%for i = 1:iter
    % randomly select 8 points and compute the fundamental matrix
    idx = randperm(num,8);
    x1s = x1(:, idx);
    x2s = x2(:, idx);

    [~,F] = fundamentalMatrix(x1s,x2s);
    matches = [];
    nonmatches = [];
    
    % for each point, if the dist < thresold, add to matches
    % else, add to nonmatches
    for j = 1:num
        d = distPointLine(x2(:,j),F*x1(:,j)) + distPointLine(x1(:,j),F'*x2(:,j));
        if (d < threshold)
            matches = [matches j];
        else
            nonmatches = [nonmatches j];
        end
    end
    
    if (length(matches) > bestRes)
        bestRes = length(matches);
        in1 = x1(1:2, matches);
        in2 = x2(1:2, matches);
        out1 = x1(1:2, nonmatches);
        out2 = x2(1:2, nonmatches);
        n = round(log(1-p)/log(1-(bestRes/num)^8));
    end
    
    i = i+1;
end

m = i;
[~,F] = fundamentalMatrix([in1;ones(1,bestRes)],[in2;ones(1,bestRes)]); 

