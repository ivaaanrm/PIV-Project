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




    finger_pred = 5;
    
    % Guradmos la máscara
    out_mask = "Masks/" + imgName(1) + ".bmp";
    imwrite(BW_pred, out_mask , "bmp");

    % Guardamos la predicción de numero de dedos
    out_finger = "Fingers/" + imgName(1) + ".txt";
    fid =fopen(out_finger, 'w' );
    fprintf(fid, '%g\n', finger_pred);
    fclose(fid);


    
end