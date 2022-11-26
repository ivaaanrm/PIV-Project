clear all

load svm_clf.mat



% Lectura de las máscaras
img_path = 'Dataset/Training-Dataset/Images/3_P_hgr1_id01_1.jpg';
img = imread(img_path);
imgName = strsplit(img_path, '/');
imgName = strsplit(string(imgName(4)), '.');


% ************ MODELOS *********** %
%[BW_pred1,maskedRGBImage] = binary_svm_clf(img, svm_clf);
%[BW_pred,maskedRGBImage] = lab_clf(maskedRGBImage);


img_gray=rgb2gray(img);
[~,threshold] = edge(img_gray,'sobel');
fudgeFactor = 0.9;
BWs = edge(img_gray,'sobel',threshold * fudgeFactor);




se90 = strel('line',3,90);
se45 = strel('line',3,45);
se_45 = strel('line',3,-45);
se0 = strel('line',3,0);
BWsdil = imdilate(BWs,[se90 se45 se_45 se0]);
BW_long = bwpropfilt(BWsdil,'Perimeter',[150 + eps(150), Inf]);

% bwmorph(BW_long, 'skel', inf);
% bwmorph(BW_long, 'endpoints');
% [labeledImage, numBlobs] = bwlabel(BW_long);
% measurements = regionprops(labeledImage, 'PixelList');
% for k = 1 : numBlobs
%     % find endpoints of this blob, then
%     imline();
%     % etc
% end



figure;
imshow(BWs)
title('Binary Gradient Mask')
figure;
imshow(BWsdil)
title('Dilated Gradient Mask')
figure;
imshow(BW_long)
title('Binary Image with Filled Holes')
% figure;
% imshow(BW)
% title('Binary Image with Filled Holes')


