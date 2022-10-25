function [y_masked ,cb_masked, cr_masked] = masked_hist_2D(name)
%ALGORITH1 Summary of this function goes here
%   Detailed explanation goes here
    img_path = "Dataset/Training-Dataset/Images/" + name + ".jpg";
    mask_path = "Dataset/Training-Dataset/Masks-Ideal/" + name + ".bmp";
    mask_inv = imread(mask_path);
    img = imread(img_path);
    
%     invertimos la máscara y 
%     transformamos los valores de la máscara de logical a uint
    mask = imcomplement(mask_inv);
    mask = im2uint8(mask)/255;

    % transformamos la imagen al espacio de color ycbcr para extraer las
    % crominancias
    ycbcr_img = rgb2ycbcr(img);

    % Separamos los valores de los dos canales de la imagen
    y = ycbcr_img(:,:,1);
    cb = ycbcr_img(:,:,2);
    cr = ycbcr_img(:,:,3);

    % Transformamos matriz de cada canal de la imagen a un vector con longitud
    % de medida igual a la cantidad de pixels. Idem con la máscara.
    y_arr = reshape(y.',1,[]);
    cb_arr = reshape(cb.',1,[]);
    cr_arr = reshape(cr.',1,[]);
    mask_arr = reshape(mask.',1,[]);
    
    % Filtramos cada canal con la máscara
    y_masked = y_arr .* mask_arr;
    cb_masked = cb_arr .* mask_arr;
    cr_masked = cr_arr .* mask_arr;
    
    % elimnamos los pixeles con valor 0
    y_masked(y_masked==0)=[];
    cb_masked(cb_masked==0)=[];
    cr_masked(cr_masked==0)=[];
    
    % array transpose
    y_masked = y_masked.';
    cb_masked = cb_masked.';
    cr_masked = cr_masked.';
    end 

