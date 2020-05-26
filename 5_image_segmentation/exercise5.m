function run_ex5()

% load image
img = imread('cow.jpg');
img = imresize(img,0.5);
% for faster debugging you might want to decrease the size of your image
% (use imresize)
% (especially for the mean-shift part!)

figure, imshow(img), title('original image')

% smooth image (6.1a)
% (replace the following line with your code for the smoothing of the image)
G = fspecial('gaussian',[5 5],5);
imgSmoothed  = imfilter(img,G,'same');
figure, imshow(imgSmoothed), title('smoothed image')

% convert to L*a*b* image (6.1b)
% (replace the folliwing line with your code to convert the image to lab
% space
colorTransform = makecform('srgb2lab');
imglab = applycform(imgSmoothed, colorTransform);
figure, imshow(imglab), title('l*a*b* image')

% (6.2)
[mapMS, peak] = meanshiftSeg(imglab);
visualizeSegmentationResults (mapMS,peak);

% (6.3)
[mapEM, cluster] = EM(imglab);
visualizeSegmentationResults (mapEM,cluster);

end