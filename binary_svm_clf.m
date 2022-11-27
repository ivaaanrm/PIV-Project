function [BW,maskedRGBImage] = binary_svm_clf(img, model)
%   Support Vector Machine model
    
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
    
%     cy = y_arr.';
    cb = cb_arr.';
    cr = cr_arr.';
    
    % Matriz con las características
    X_test = [double(cb),double(cr)];
    
    % predicción de la nueva máscara
    BW_pred = predict(model, X_test);
    
    % Reconstruir máscara
    [~, height, ~] = size(img);
    BW = logical(reshape(BW_pred,height,[]));
    BW = BW.';
    
    % Initialize output masked image based on input image.
    maskedRGBImage = img;

    % Set background pixels where BW is false to zero.
    maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end
