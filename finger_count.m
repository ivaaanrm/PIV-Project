clear all
close all

% Lectura de las máscaras
mask = imread("Dataset/Training-Dataset/Masks-Ideal/5_A_hgr2B_id06_1.bmp");
mask = imcomplement(mask);

[BW] = segmentImage(mask);

fingersMask = mask - BW;

% Erode mask with default
radius = 3;
decomposition = 0;
se = strel('disk', radius, decomposition);
fingersMask = imerode(fingersMask, se);

% Centroide del area
centroid  = regionprops(BW).Centroid;

[B] = bwboundaries(fingersMask);

dmax = 0;
for k = 1:length(B)
   boundary = B{k};
   for i = 1:length(boundary)
       d = norm(boundary(i,:)-centroid);
       if d >dmax
           dmax = d;
%            maxPoint = fliplr(boundary(i,:));
          maxPoint = boundary(i,:);
       end
   end
%    s(k) = struct("dmax",dmax,"maxPoint",maxPoint);
   a{k} = maxPoint;
end

figure
imshow(fingersMask)
hold on
for k = 1:length(a)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 1)
end
viscircles(centroid, 1)
hold off


% figure
% subplot(131)
% imshow(mask)
% subplot(132)
% imshow(BW)
% hold on
% 
% viscircles(centroid, 2)
% hold off
% subplot(133)
% imshow(fingers)

out_mask = "";
imwrite(fingersMask, "Training/out.jpg" , "jpg");


