clear all

load svm_clf.mat



% Lectura de las máscaras
img_path = 'Dataset/Training-Dataset/Images/5_P_hgr1_id01_1.jpg';
img = imread(img_path);
imgName = strsplit(img_path, '/');
imgName = strsplit(string(imgName(4)), '.');


% ************ MODELOS *********** %
[BW_pred1,maskedRGBImage] = binary_svm_clf(img, svm_clf);
[BW_pred,maskedRGBImage] = lab_clf(maskedRGBImage);

[BW_edge] = postprocessmasks(img);
    
mask = immultiply(BW_edge, BW_pred);
mask = bwareafilt(mask,1);

[x,y] = size(mask);
    area =x*y;
    if bwarea(mask) > area*0.3
        [mask] = postprocessmasks2(img, mask);
    end


% Guradmos la máscara
out_mask = "Masks-contours/" + imgName(1) + ".bmp";
imwrite(BW_edge, out_mask , "bmp");

figure,
subplot(141);
imshow(img);
subplot(142);
imshow(BW_edge);
subplot(143);
imshow(BW_pred);
subplot(144);
imshow(mask);
