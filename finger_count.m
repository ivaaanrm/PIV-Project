clear all

load svm_clf.mat
% load SVM_clf


    % Lectura de las máscaras
img = imread("Dataset/Training-Dataset/Images/2_A_hgr2B_id03_1.jpg");

% ************ MODELOS *********** %
[BW_pred1,maskedRGBImage] = binary_svm_clf(img, svm_clf);
[BW_pred,maskedRGBImage] = lab_clf(maskedRGBImage);

for 

k = convhull(BW_pred);

figure
imshow(BW_pred)

% % Guradmos la máscara
% out_mask = "Masks/" + imgName(1) + ".bmp";
% imwrite(BW_pred, out_mask , "bmp");
%     


