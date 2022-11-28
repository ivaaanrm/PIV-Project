tic 
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


% ********  Mejora del sistema usando contornos ***********%
% Usamos el detector de contornos canny para detectar los contornos de
% la mano. Closing para cerrar el objeto. LLenamos los agujeros.
[BW_edge] = postprocessmasks(img);
mask = immultiply(BW_edge, BW_pred);
mask = bwareafilt(mask,1);

% Otro detector de contornos para diferenciar objetos y elegimos el que
% corresponde a la mano.
[x,y] = size(mask);
    area =x*y;
    if bwarea(mask) > area*0.3
        [mask] = postprocessmasks2(img, mask);
    end

% Guradmos la máscara
out_mask =  imgName(1) + ".bmp";
imwrite(mask, out_mask , "bmp");

toc

% plot pipeline
figure,
subplot(141);
imshow(img);
subplot(142);
imshow(BW_edge);
subplot(143);
imshow(BW_pred);
subplot(144);
imshow(mask);
