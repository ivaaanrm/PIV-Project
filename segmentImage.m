function [BW] = segmentImage(BW)

% Open mask with disk
radius = 26;
decomposition = 0;
se = strel('disk', radius, decomposition);
BW = imopen(BW, se);

% Dilate mask with disk
radius = 8;
decomposition = 0;
se = strel('disk', radius, decomposition);
BW = imdilate(BW, se);

% % Create masked image.
% maskedImage = X;
% maskedImage(~BW) = 0;
end

