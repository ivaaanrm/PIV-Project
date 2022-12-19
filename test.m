% 2_P_hgr1_id08_3

img = imread("Dataset/Validation-Dataset/Masks-Ideal/2_P_hgr1_id08_3.bmp");
img = imresize(img, 3);
figure
imshow(imcomplement(img))
mask = imcomplement(img);
% Nos quedamos solo con la palma de la mano y calculamos su centroide

[BW] = segmentImage(mask);

if sum(BW)==0
    [BW] = segmentImage(mask);
end

figure
imshow(BW)
%     % Distance transformation
%     [D,IDX] = bwdist(imcomplement(mask));
%     mask_transform = repmat(rescale(D), [1 1 3]);
% punto más alejado de los bordes (debería ser el centro de la palma)
%     maximum = max(max(D));
%     [y,x]=find(D==maximum);
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

figure
imshow(fingersMask)