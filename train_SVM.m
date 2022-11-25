clear all
close all

name = "2_A_hgr2B_id04_1";
img_path = "Dataset/Training-Dataset/Images/" + name + ".jpg";
mask_path = "Dataset/Training-Dataset/Masks-Ideal/" + name + ".bmp";
mask_inv = imread(mask_path);
img = imread(img_path);

% Diezmamo las imagen para reducir el nuúmero de pixels con el que
% entrenamos el modelo.
[width, height, ~] = size(img);
DIEZMADO = 5;

I = imresize(img,[width/DIEZMADO,height/DIEZMADO],'Method','bilinear');
BW = imresize(mask_inv,[width/DIEZMADO,height/DIEZMADO],'Method','bilinear');

imshow(I)

%% Image pre processing

%     invertimos la máscara y 
%     transformamos los valores de la máscara de logical a uint
BW = imcomplement(BW);
BW = im2uint8(BW)/255;

% transformamos la imagen al espacio de color ycbcr para extraer las
% crominancias
ycbcr_img = rgb2ycbcr(I);

% Separamos los valores de los dos canales de la imagen
y = ycbcr_img(:,:,1);
cb = ycbcr_img(:,:,2);
cr = ycbcr_img(:,:,3);

% Transformamos matriz de cada canal de la imagen a un vector con longitud
% de medida igual a la cantidad de pixels. Idem con la máscara.
y_arr = reshape(y.',1,[]);
cb_arr = reshape(cb.',1,[]);
cr_arr = reshape(cr.',1,[]);
mask_arr = reshape(BW.',1,[]);

y_ = y_arr.';
cb = cb_arr.';
cr = cr_arr.';
mask = mask_arr.';

% 
X = [double(cb),double(cr)];

%% Train the SVM Classifier
% Como datos de entrenamiento usamos todos los pixeles de una imagen
% correspondientes a las componentes de crominancia y su correspondiente

rng(1);  % For reproducibility
svm_clf = fitcsvm(X,mask);

%% Guardamos el modelo
% save svm_clf

%% Plot results
sv = svm_clf.SupportVectors;

figure
gscatter(X(:,1),X(:,2),mask)
title("Componentes Cr-Cb y vectores soporte")
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('skin','background','Support Vector')
hold off
grid on
%%

% % Predict scores over the grid
d = 0.02;
[x1Grid,x2Grid] = meshgrid(min(X(:,1)):d:max(X(:,1)),...
    min(X(:,2)):d:max(X(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
[~,scores] = predict(svm_clf,xGrid);

Plot the data and the decision boundary
figure;
h(1:2) = gscatter(X(:,1),X(:,2),mask,'rb','.');
hold on
ezpolar(@(x)1);
h(3) = plot(X(svm_clf.IsSupportVector,1),X(svm_clf.IsSupportVector,2),'ko');
contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
legend(h,{'-1','+1','Support Vectors'});
axis equal
hold off

%% Validación del modelo con una imagen de test

name = "2_P_hgr1_id05_2";
img_path = "Dataset/Training-Dataset/Images/" + name + ".jpg";
mask_path = "Dataset/Training-Dataset/Masks-Ideal/" + name + ".bmp";
mask_inv = imcomplement(imread(mask_path));
img = imread(img_path);


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
mask_arr = reshape(BW.',1,[]);

y_ = y_arr.';
cb = cb_arr.';
cr = cr_arr.';
mask = mask_arr.';

X_test = [double(cb),double(cr)];

BW_pred = predict(svm_clf, X_test);
%%
% Reconstruir máscara
[width, height, ~] = size(img);

pred_mask = logical(reshape(BW_pred,height,[]));
pred_mask = pred_mask.';

figure
subplot(131)
imshow(img)
title("Imagen original")
subplot(132)
imshow(mask_inv)
title("Máscara ideeal")
subplot(133)
imshow(pred_mask)
title("Estimación de la máscara")

%%
% % Predict scores over the grid
% d = 0.02;
% [x1Grid,x2Grid] = meshgrid(min(x_(:,1)):d:max(X(:,1)),...
%     min(X(:,2)):d:max(X(:,2)));
% xGrid = [x1Grid(:),x2Grid(:)];
% [~,scores] = predict(cl,xGrid);
% 
% % Plot the data and the decision boundary
% figure;
% h(1:2) = gscatter(X(:,1),X(:,2),mask,'rb','.');
% hold on
% ezpolar(@(x)1);
% h(3) = plot(X(cl.IsSupportVector,1),X(cl.IsSupportVector,2),'ko');
% contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
% legend(h,{'-1','+1','Support Vectors'});
% axis equal
% hold off




