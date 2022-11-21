clear all

% Importamos la imagen y la máscara.
name = '0_A_hgr2B_id01_1';
img_path = "Dataset/Training-Dataset/Images/" + name + ".jpg";
mask_path = "Dataset/Training-Dataset/Masks-Ideal/" + name + ".bmp";
mask_inv = imread(mask_path);
img = imread(img_path);

mask = imcomplement(mask_inv);
% mostramos la imagen original
figure
subplot(1,2,1);
imshow(mask);
title('máscara')
% transformamos los valores de la máscara de logical a uint
mask = im2uint8(mask)/255;


% transformamos la imagen al espacio de color ycbcr para extraer las
% crominancias
ycbcr_img = rgb2ycbcr(img);
subplot(1,2,2);
imshow(ycbcr_img);
title('Imagen transformada en el espacio de color ycbcr')


%lab_img = rgb2lab(img);
%figure
%imshow(lab_img);

% Separamos los valores de los dos canales de la imagen
cb = ycbcr_img(:,:,2);
cr = ycbcr_img(:,:,3);

% Transformamos matriz de cada canal de la imagen a un vector con longitud
% de medida igual a la cantidad de pixels. Idem con la máscara.
cb_arr = reshape(cb.',1,[]);
cr_arr = reshape(cr.',1,[]);
mask_arr = reshape(mask.',1,[]);

% mask_arr = mask_arr_inv;
% max(cr_arr)
% min(cr_arr)
% ones_arr = ones(1,length(mask_arr_inv));
% mask_arr = cast(ones_arr, 'uint8') - mask_arr_inv;

% Filtramos cada canal con la máscara
cb_masked = cb_arr .* mask_arr;
cr_masked = cr_arr .* mask_arr;

% reconstrucción de la imagen
s = size(mask);
new_cb = reshape(cb_arr,s(2),[]);
new_cr = reshape(cr_masked,s(2),[]);

figure
subplot(1,2,1)
imshow(new_cr)
subplot(1,2,2)
imshow(new_cb)

% Mostramos le histograma 2D de los canalese cb y cr
figure
subplot(1,2,1);
histogram2(cb_arr, cr_arr, 'FaceColor', 'flat');
title('cb-cr Histogram'), ylabel('cr'), xlabel('cb'),xlim([100, 160]);

% % Mostramos el histograma 2D de los canales cb y cr filtrados
% subplot(1,2,2);
% histogram2(cb_masked, cr_masked, 'FaceColor', 'flat');
% title('cb-cr 2D masked Histogram'), ylabel('cr'), xlabel('cb'), xlim([80, 160]), ylim([100, 180]);



idx = find(cb_masked==0);
cb_masked(idx)=[];
idx_ = find(cr_masked==0);
cr_masked(idx_)=[];

cb_masked = cb_masked.';
cr_masked = cr_masked.';


[N_cb,edges_cb] = histcounts(cb_masked);
[N_cr,edges_cr] = histcounts(cr_masked);


subplot(1,2,2);
hist3([cb_masked, cr_masked],{0:2:max(edges_cb) 0:2:max(edges_cr)}, 'CdataMode','auto','FaceColor','interp')
title('cb-cr masked Histogram'), ylabel('cr'), xlabel('cb'),
xlim([min(edges_cb) max(edges_cb)])
ylim([min(edges_cr) max(edges_cr)])

%
% 
% hist3(M, [15 15])
