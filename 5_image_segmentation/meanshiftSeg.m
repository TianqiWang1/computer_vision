function [map, peak] = meanshiftSeg(img)
    img = double(img);
    [h,w,~] = size(img);
    X = reshape(img,[h * w,3]);
    [Xn,T] = normalize(X');
    Xn = Xn(1:3,:)';
    r = 5;

    % initialize peak and map
    peak = [];
    map = zeros(h,w);
     
    % create first peak
    id = 1;
    peak(1,:) = find_peak(Xn,Xn(1,:),r);
    map(1) = 1;
    
    for i = 2:h*w
        % Find peak for given pixel 
        mode = find_peak(Xn,Xn(i,:),r);
        
        % calculate distance from the new mode to existing peaks
        dists = sqrt(sum(((peak-repmat(mode,[id,1])).^2),2));
        % idx of existing peaks with distance smaller than r/2 to the new peak
        index = find(dists < r/2,1);
        % create a new peak
        if isempty(index)
            peak(end+1,:) = mode;
            id = id + 1;
            map(i) = id;
        % merge peaks
        else
            map(i) = index;
        end
    end 
    
    peakh = [peak';ones(1,id)];
    peaku = T \ peakh;
    peak = peaku(1:3,:)';
end