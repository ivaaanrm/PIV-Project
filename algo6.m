clear all

load svm_clf.mat
load trainedModel.mat
load SVM_model.mat
load KNN_model.mat

files = dir(['Dataset/Validation-Dataset/Masks-Ideal/', '/*.bmp']);
%files = dir(['Dataset/Training-Dataset/Masks-Ideal/', '/*.bmp']);

for i = 1 : length(files)
    % Lectura de las máscaras
    img = imread(files(i).folder + "/" + files(i).name);
    imgName = files(i).name;
    imgName = strsplit(imgName, '.');

    [width, height, ~] = size(img);

    if width*height<=50000
        img = imresize(img,3.5);
    end
    
    % Eliminamos la palma de la mano para quedarnos solo con la región de
    % los dedos
    fingersMask = remove_palm(imcomplement(img));

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
                if fingersMask(round(stats(j).Centroid(2)), round(stats(j).Centroid(1))) == 0
                    pred=2;
                    mask_centroids = insertMarker(255*uint8(fingersMask), round(stats(j).Centroid), 'x', 'color', 'red', 'size', 20);
                    figure
                    imshow(mask_centroids)
                end
            end
           
            sumFingers = sumFingers+pred;
        end
    end

    if sumFingers>0
        x = sum(centroids_(:,1))/length(centroids_(:,1));
        y = sum(centroids_(:,2))/length(centroids_(:,1));
        mask_centroids = insertMarker(255*uint8(fingersMask), [x y], 'x', 'color', 'red', 'size', 20);

        for k=1:length(centroids_(:,1))
            d = norm([x y]-centroids_(k,:));
            if d>230
                sumFingers = sumFingers-1;
%                 figure
%                 imshow(fingersMask)
            end
        end
    end


    % Guradmos la máscara solo de los dedos
%     out_mask = "fingers_masks_val/" + imgName(1) + ".bmp";
%     imwrite(fingersMask, out_mask , "bmp");
    
    finger_pred = sumFingers;
    if finger_pred>5
        finger_pred=5;
    end
    
    % Guradmos la máscara
%     out_mask = "centroids_masks/" + imgName(1) + ".jpg";
%     imwrite(mask_centroids, out_mask , "jpg");

%     % Guradmos la máscara solo de los dedos
%     out_mask = "fingers_masks_train/" + imgName(1) + ".bmp";
%     imwrite(fingersMask, out_mask , "bmp");

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
