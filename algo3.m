clear all

load svm_clf.mat

files = dir(['Dataset/Training-Dataset/Images/', '/*.jpg']);

for i = 1 : length(files)
    % Lectura de las máscaras
    img = imread(files(i).folder + "/" + files(i).name);
    imgName = files(i).name;
    imgName = strsplit(imgName, '.');
    
    % ************ MODELOS *********** %
    [BW_pred1,maskedRGBImage] = binary_svm_clf(img, svm_clf);
    [BW_pred,maskedRGBImage] = lab_clf(maskedRGBImage);
    
    % ********  Mejora del sistema usando contornos ***********%
    % Usamos el detector de contornos canny para detectar los contornos de
    % la mano. Closing para cerrar el objeto. LLenamos los agujeros.
    [BW_edge] = postprocessmasks(img);
    pred_mask = immultiply(BW_edge, BW_pred);
    pred_mask = bwareafilt(pred_mask,1);
    pred_mask = imfill(pred_mask, 'holes');
    
    % Otro detector de contornos para diferenciar objetos y elegimos el que
    % corresponde a la mano.
   [width,height] = size(pred_mask);
    area =width*height;
    if bwarea(pred_mask) > area*0.5
        [pred_mask] = postprocessmasks2(img, pred_mask);
    end

    % Guradmos la máscaras
    out_mask = "Masks/" + imgName(1) + ".bmp";
    imwrite(pred_mask, out_mask , "bmp");
    
end


