clear all
close all

files = dir(['Dataset/Training-Dataset/Images/', '/*.jpg']);

for i = 1 : length(files)
    img = imread(files(i).folder + "/" + files(i).name);
    imgName = files(i).name;
    imgName = strsplit(imgName, '.');

    yCbCr_img = rgb2ycbcr(img);

    % ************ MODELOS *********** %
%   BW_pred = threshoold_clasifier(yCbCr_img);
    [BW_pred,maskedRGBImage] = lab_clf(img);
%     [BW_pred,maskedRGBImage] = yCrCb_clf(img);
%     [BW_pred,maskedImage] = kmeans_clf(img);

    % Guradmos la máscara
    out_mask = "Masks/" + imgName(1) + ".bmp";
    imwrite(BW_pred, out_mask , "bmp");
end
