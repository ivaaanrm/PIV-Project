function [BW] = postprocessmasks2(img, BW)

img_gray=rgb2gray(img);

% Get contours using sobel
[~,threshold] = edge(img_gray,'sobel');
fudgeFactor = 0.9;
BWs = edge(img_gray,'sobel',threshold * fudgeFactor);

% Close mask with disk
radius = 1;
decomposition = 0;
se = strel('disk', radius, decomposition);
BWs = imdilate(BWs,se);

BWs = imcomplement(BWs);
BW = immultiply(BW, BWs);



radius2 = 1;
decomposition = 0;
se2 = strel('disk', radius2, decomposition);
BW = imclose(BW, se2);

BW = imfill(BW, 'holes');
BW = bwareafilt(BW,1);

radius2 = 4;
decomposition = 0;
se2 = strel('disk', radius2, decomposition);
BW = imclose(BW, se2);
