function hist  = color_histogram( xMin, yMin, xMax, yMax, frame, hist_bin )
% This function should calculate the normalized histogram of RGB colors in
% the bounding box within the current video frame. The histogram is
% obtained by binning each color chanel into hist_bin bins. 

    xMin = round(max(1,xMin));
    yMin = round(max(1,yMin));
    xMax = round(min(xMax,size(frame,2)));
    yMax = round(min(yMax,size(frame,1)));

    R = frame(yMin:yMax,xMin:xMax,1);
    G = frame(yMin:yMax,xMin:xMax,2);
    B = frame(yMin:yMax,xMin:xMax,3);

    [yR, ~] = imhist(R, hist_bin);
    [yG, ~] = imhist(G, hist_bin);
    [yB, ~] = imhist(B, hist_bin);

    hist = [yR; yG; yB];
    hist = hist/sum(hist);

end

