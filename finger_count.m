clear all
close all

% Lectura de las máscaras
mask = imread("Dataset/Training-Dataset/Masks-Ideal/4_P_hgr1_id05_1.bmp");
mask = imcomplement(mask);


% Nos quedamos solo con la palma de la mano y calculamos su centroide
[BW] = segmentImage(mask);
centroid  = regionprops(BW).Centroid;


% Distance transformation
[D,IDX] = bwdist(imcomplement(mask));
mask_transform = repmat(rescale(D), [1 1 3]);

% punto más alejado de los bordes (debería ser el centro de la palma)
maximum = max(max(D));
[y,x]=find(D==maximum);


% restamos la máscara sin dedos a la máscara original para quedarnos solo
% con las regiones de dedos.
fingersMask = mask - BW;

% Eliminamos los valores de -1
sliderBW = (fingersMask(:,:,1) > 0 );
fingersMask = sliderBW;

% Erode mask with default
radius = 3;
decomposition = 0;
se = strel('disk', radius, decomposition);
fingersMask = imerode(fingersMask, se);

% boundaries finger areas 
B = bwboundaries(fingersMask);


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
       if d>dmax
          dmax = d;
          maxPoint = boundary(i,:);
       end
   end
   plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 1)
%    a{k} = maxPoint;
%    viscircles(a{k}, 1)
end
% viscircles(centroid, 1)

hold off


%% Plot pipeline
figure
subplot(221)
imshow(mask)
title("original mask")
subplot(222)
imshow(mask_transform)
hold on
viscircles([x,y], 1)
hold off
title("Distance transformation")
subplot(223)
imshow(BW)
hold on
viscircles(centroid, 2)
hold off
title("mask opened + eroded")
subplot(224)
imshow(fingersMask)
hold on
viscircles([x,y], 1)
hold off
title("original - opened")

% Distance to contour region pixel
figure
t = 1:1:length(d_); 
plot(t,d_)
yline(mean(d_))
title("Distancia del contorno al centro de masa")
grid on


