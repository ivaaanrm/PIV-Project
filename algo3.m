clear all

load svm_clf.mat

files = dir(['Dataset/Validation-Dataset/Images/', '/*.jpg']);

for i = 1 : length(files)
    % Lectura de las máscaras
    img = imread(files(i).folder + "/" + files(i).name);
    imgName = files(i).name;
    imgName = strsplit(imgName, '.');
    

    % ************ MODELOS *********** %
    [BW_pred1,maskedRGBImage] = binary_svm_clf(img, svm_clf);
    [BW_pred,maskedRGBImage] = lab_clf(maskedRGBImage);

    % Guradmos la máscara
    out_mask = "Masks/" + imgName(1) + ".bmp";
    imwrite(BW_pred, out_mask , "bmp");
    
end


