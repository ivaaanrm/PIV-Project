clear all
close all

% Lectura de las máscaras
mask = imread("Dataset/Training-Dataset/Masks-Ideal/4_P_hgr1_id01_2.bmp");
mask = imcomplement(mask);

[BW] = segmentImage(mask);

fingersMask = mask - BW;

% Erode mask with default
radius = 3;
decomposition = 0;
se = strel('disk', radius, decomposition);
fingersMask = imerode(fingersMask, se);

imwrite(fingersMask, "Training/out.bmp" , "bmp");

% Centroide del area
centroid  = regionprops(BW).Centroid;
% 
B = bwboundaries(imread("Training/out.bmp"),4,"noholes");
d_ = [];
dmax = 0;

figure
imshow(fingersMask)
hold on

for k = 1:length(B)
   boundary = B{k};
   for i = 1:length(boundary)
       d = norm(boundary(i,:)-centroid);
       d_ = vertcat(d_,d);
       if d >dmax
          dmax = d;
          maxPoint = boundary(i,:);
       end
   end
   plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 1)
   a{k} = maxPoint;
   viscircles(a{k}, 1)
end
viscircles(centroid, 1)
hold off

%%

% figure
% imshow(fingersMask)
% hold on
% for k = 1:length(a)
%    boundary = B{k};
%    plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 1)
%    viscircles(a{k}, 1)
% 
% end
% viscircles(centroid, 1)
% hold off


figure
subplot(131)
imshow(mask)
subplot(132)
imshow(BW)
hold on

viscircles(centroid, 2)
hold off
subplot(133)
imshow(fingersMask)



%%
figure
t = 1:1:length(d_);
plot(t,d_)


