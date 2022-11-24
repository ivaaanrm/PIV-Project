clear all

load svm_clf.mat

% Importamos la imagen 
name = '2_P_hgr1_id01_1';
img_path = "Dataset/Training-Dataset/Images/" + name + ".jpg";
mask_path = "Dataset/Training-Dataset/Masks-Ideal/" + name + ".bmp";
img = imread(img_path);

% Modelos de predicción
[BW_pred1,maskedRGBImage] = binary_svm_clf(img, svm_clf);
[BW_pred,maskedRGBImage] = lab_clf(maskedRGBImage);


% Algo 4
% Importamos la máscara ideal para calcular el F1-score
out_mask = "Masks/" + name + ".bmp";
ideal_mask = imcomplement(imread(mask_path));
% Generamos la confusion matrix
[tp, tn, fn, fp, precision, recall] = metrics(logical(BW_pred), ideal_mask);
f1score = f1_score(precision, recall);

figure
subplot(1,2,1)
imshow(logical(BW_pred))
subplot(1,2,2)
imshow(ideal_mask)

