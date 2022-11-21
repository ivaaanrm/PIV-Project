function [BW,maskedRGBImage] = lab_clf(RGB)

% Convert RGB image to chosen color space
I = rgb2lab(RGB);

% Define thresholds for channel 1 based on histogram settings
channel1Min = 6.5; % antes 0
channel1Max = 80;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 3; % antes 1
channel2Max = 23.583; % 

% Define thresholds for channel 3 based on histogram settings
channel3Min = 2.5;
channel3Max = 30.929; %antes 26

% 0.89
% Define thresholds for channel 1 based on histogram settings
% channel1Min = 5.136; % antes 0
% channel1Max = 80;
% 
% % Define thresholds for channel 2 based on histogram settings
% channel2Min = 0.5; % antes 1
% channel2Max = 23.583; % 
% 
% % Define thresholds for channel 3 based on histogram settings
% channel3Min = 0.0;
% channel3Max = 30.929; %antes 26

% 0.91
% % Define thresholds for channel 1 based on histogram settings
% channel1Min = 13.136; % antes 0
% channel1Max = 78.467;
% 
% % Define thresholds for channel 2 based on histogram settings
% channel2Min = 0.665; % antes 1
% channel2Max = 23.583; % 
% 
% % Define thresholds for channel 3 based on histogram settings
% channel3Min = -4.617;
% channel3Max = 30.929; %antes 26


% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;

% Fill holes
BW = imfill(BW, 'holes');


% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end
