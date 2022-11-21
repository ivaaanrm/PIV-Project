clear all

name = '2_P_hgr1_id01_1';
img_path = "Dataset/Training-Dataset/Images/" + name + ".jpg";
mask_path = "Dataset/Training-Dataset/Masks-Ideal/" + name + ".bmp";
out_mask = "Masks/" + name + ".bmp";

img = imread(img_path);
ideal_mask = imcomplement(imread(mask_path));
% --------------------------------
L = 15;
threshRGB = multithresh(img,L);

threshForPlanes = zeros(3,L);			

for i = 1:3
    threshForPlanes(i,:) = multithresh(img(:,:,i),L);
end

value = [0 threshRGB(2:end) 255]; 
quantRGB = imquantize(img, threshRGB, value);

% --------------------------------
% imaq = Cuantificador_Adaptado(img, L);
% Modelo con threshoolds
% BW_1 = threshoold_clasifier(imaq);
[BW_1,maskedRGBImage] = lab_clf(quantRGB);

imwrite(BW_1, out_mask, "bmp");
% filtramos la imagen con la máscara
BW_1 = uint8(BW_1);
filtered_img_1 = img .* cat(3, BW_1, BW_1, BW_1);


%BW_2 = lieneal_clasifier(filtered_img_1)


% Algo 4
% Generamos la confusion matrix
[tp, tn, fn, fp, precision, recall] = metrics(logical(BW_1), ideal_mask);
f1score = f1_score(precision, recall);

figure
imshow(quantRGB)

figure
subplot(1,2,1)
imshow(logical(BW_1))
subplot(1,2,2)
imshow(ideal_mask)

% figure
% imshow(filtered_img_1);
% figure
% imshow(yCbCr_img)
