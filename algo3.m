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
    
    
    [BW_edge] = postprocessmasks(img);
    
    mask = immultiply(BW_edge, BW_pred);
    mask = bwareafilt(mask,1);
    mask = imfill(mask, 'holes');
    
   [x,y] = size(mask);
    area =x*y;
    if bwarea(mask) > area*0.5
        [mask] = postprocessmasks2(img, mask);
    end

    
    % Guradmos la máscara
    out_mask = "Masks/" + imgName(1) + ".bmp";
    imwrite(mask, out_mask , "bmp");
    
end


