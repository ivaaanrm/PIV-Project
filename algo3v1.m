clear all

load svm_clf.mat
% load SVM_clf

files = dir(['Dataset/Validation-Dataset/Images/', '/*.jpg']);

errs = [];

for i = 1 : length(files)
    % Lectura de las máscaras
    img = imread(files(i).folder + "/" + files(i).name);
    imgName = files(i).name;
    imgName = strsplit(imgName, '.');
    
    ideal_mask_path = "Dataset/Validation-Dataset/Masks-Ideal/" + imgName(1) + ".bmp";
    ideal_mask = imcomplement(imread(ideal_mask_path));
    

    % ************ MODELOS *********** %
    [BW_pred1,maskedRGBImage] = binary_svm_clf(img, svm_clf);
    [BW_pred,maskedRGBImage] = lab_clf(maskedRGBImage);
    

%     [BW_pred,maskedRGBImage] = lab_clf_2(maskedRGBImage);
%     BW_pred = threshoold_clasifier(yCbCr_img);
%     [BW_pred,maskedRGBImage] = yCrCb_clf(img);

%     [BW_pred,maskedRGBImage] = kmeans_clf(img);
%     
%     properties = regionprops(BW_pred, {'Area', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter'});
%     area = properties.Area;
%     [width, height, ~] = size(BW_pred);
%     Atot = width*height;
%     th = area/Atot;
%     if th > 0.5 || area < 200
%         BW_pred = imcomplement(BW_pred);
%     end
%     [BW_pred,maskedRGBImage] = lab_clf(maskedRGBImage);

    
    % Calculamos el MSE de cada estimación.
    err = immse(double(BW_pred), double(ideal_mask)); 
    errs = vertcat(errs, err);
    
    % Guradamos las máscaras con peor estimación
    if err > 0.05
        out_mask = "worse_masks/" + imgName(1) + ".jpg";
        imwrite(maskedRGBImage, out_mask , "jpg");
    end
    
    % Guradmos la máscara
    out_mask = "Masks/" + imgName(1) + ".bmp";
    imwrite(BW_pred, out_mask , "bmp");
    
end

% Visualizar el MSE de cada imagen. Comprobamos el rendimineto del
% clasificador.
figure
x=1:1:length(errs);
scatter(x,errs, 'red')
title("error cuadrático medio de cada estimación")
yline(0.05,'-','Threshold');
grid on


