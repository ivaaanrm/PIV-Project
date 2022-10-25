clear all

name = '0_A_hgr2B_id11_1';
img_path = "Dataset/Validation-Dataset/Images/" + name + ".jpg";
mask_path = "Dataset/Validation-Dataset/Masks-Ideal/" + name + ".bmp";
out_mask = "Masks/" + name + ".bmp";

img = imread(img_path);
ideal_mask = imcomplement(imread(mask_path));

yCbCr_img = rgb2ycbcr(img);

% Modelo con threshoolds
BW_1 = threshoold_clasifier(yCbCr_img);
% [BW_1,maskedRGBImage] = lab_clf(img);

imwrite(BW_1, out_mask, "bmp");
% filtramos la imagen con la máscara
BW_1 = uint8(BW_1);
filtered_img_1 = yCbCr_img .* cat(3, BW_1, BW_1, BW_1);


%BW_2 = lieneal_clasifier(filtered_img_1)


% Algo 4
% Generamos la confusion matrix
[tp, tn, fn, fp, precision, recall] = metrics(logical(BW_1), ideal_mask);
f1score = f1_score(precision, recall);

figure
subplot(1,2,1)
imshow(logical(BW_1))
subplot(1,2,2)
imshow(ideal_mask)

% figure
% imshow(filtered_img_1);
% figure
% imshow(yCbCr_img)
