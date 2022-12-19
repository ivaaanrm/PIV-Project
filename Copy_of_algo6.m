clear all

load svm_clf.mat
load trainedModel.mat
load SVM_model.mat
load KNN_model.mat

%files = dir(['Dataset/Training-Dataset/Images/', '/*.jpg']);
files = dir(['Dataset/Validation-Dataset/Masks-Ideal/', '/*.bmp']);
% files = dir(['Dataset/Training-Dataset/Masks-Ideal/', '/*.bmp']);
% files = dir(['Masks/', '/*.bmp']);


% out_stats = "stats.csv"
% fid =fopen(out_stats, 'w' );
% fprintf(fid, '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n', 'Area', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter','id', 'target');


for i = 1 : length(files)
    % Lectura de las máscaras
    img = imread(files(i).folder + "/" + files(i).name);
    imgName = files(i).name;
    imgName = strsplit(imgName, '.');
    ref = strsplit(imgName{1}, '_');
    ref = str2num(['uint8(',ref{1},')']);

    mask = imcomplement(img);
    

%     % ************ MODELOS *********** %
%     [BW_pred1,maskedRGBImage] = binary_svm_clf(img, svm_clf);
%     [BW_pred,maskedRGBImage] = lab_clf(maskedRGBImage);

    % --------------------------
%     % Nos quedamos solo con la palma de la mano y calculamos su centroide
%     [BW] = segmentImage(mask);
%     % Distance transformation
%     [D,IDX] = bwdist(imcomplement(mask));
%     mask_transform = repmat(rescale(D), [1 1 3]);
%     % punto más alejado de los bordes (debería ser el centro de la palma)
%     maximum = max(max(D));
%     [y,x]=find(D==maximum);
%     % restamos la máscara sin dedos a la máscara original para quedarnos solo
%     % con las regiones de dedos.
%     fingersMask = mask - BW;
%     % Eliminamos los valores de -1
%     sliderBW = (fingersMask(:,:,1) > 0 );
%     fingersMask = sliderBW;
%     % Erode mask with default
%     radius = 3;
%     decomposition = 0;
%     se = strel('disk', radius, decomposition);
%     fingersMask = imerode(fingersMask, se);

    % ----------------------------
    
    % Eliminamos la palma de la mano para quedarnos solo con la región de
    % los dedos
    fingersMask = remove_palm(mask);

    stats = regionprops(fingersMask, {'Area', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter', 'Centroid'});
    centroids_ = []; 
    sumFingers = 0;
    if ~isempty(stats)
    
        for j=1:length(stats)
            pred = trainedModel.predictFcn(struct2table(stats(j)));        
%             pred = SVM_model.predictFcn(struct2table(stats(j)));     
%             pred = KNN_model.predictFcn(struct2table(stats(j)));        
            if pred>0
                centroids_ = vertcat(centroids_,stats(j).Centroid);
            end
            sumFingers = sumFingers+pred;
        end
    end

%     for k=1:length(centroids_)
%         d = norm(centroids_(k,:)-centroids_())
%     end

    
    

%     if ~isempty(stats)
%         for j=1:length(stats)
%     % 
%     %         idx = find([stats(j).MajorAxisLength]/[stats(j).MinorAxisLength] > 2); 
%     %         fingersMask = ismember(fingersMask,idx);
%             fprintf(fid, '%f,%f,%f,%f,%f,%f,%f,%f,%f,%s,%d\n', stats(j).Area, stats(j).ConvexArea, stats(j).Eccentricity, ...
%                                                     stats(j).EquivDiameter, stats(j).EulerNumber, stats(j).MajorAxisLength, ...
%                                                     stats(j).MinorAxisLength, stats(j).Orientation, stats(j).Perimeter, imgName{1}, ref);
%             
%         end
%     else
%         fprintf(fid, '%f,%f,%f,%f,%f,%f,%f,%f,%f,%s,%d\n', 0, 0, 0, ...
%                                                     0, 0, 0, ...
%                                                     0, 0, 0,imgName{1} ,ref);
% 
%     end 
    % -------------------------------
    
    % Guradmos la máscara
%     out_mask = "Masks/" + imgName(1) + ".bmp";
%     imwrite(BW_pred, out_mask , "bmp");

    % Guradmos la máscara solo de los dedos
%     out_mask = "fingers_masks_val/" + imgName(1) + ".bmp";
%     imwrite(fingersMask, out_mask , "bmp");
    
    finger_pred = sumFingers;
    if finger_pred>5
        finger_pred=5;
    end

    % Guardamos la predicción del numero de dedos
    out_finger = "Fingers_knn_single/" + imgName(1) + ".txt";
    fid =fopen(out_finger, 'w' );
    fprintf(fid, '%g\n', finger_pred);

    % Guardamos la predicción del numero de dedos
%     out_finger = "out_fingers.txt";
%     fid =fopen(out_finger, 'a' );
%     fprintf(fid, '%s,%g\n', imgName{1},finger_pred);
end

fclose(fid);
