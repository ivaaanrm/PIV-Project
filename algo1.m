clear all

files = dir(['Dataset_cop/Training-Dataset/Images/', '/*.jpg']);

% Por cada imagen del directorio de entrenamiento calculamos el histograma
% 2D de de la imagen filtrada con los pixeles que corresponden a la piel.
L_arr = [];
a_arr = [];
b_arr = [];
for i = 1 : length(files)
        % Obtenemos el nombre del fichero y calculamos el histigrama 2D de
        % las componentes de crominancia de los pixeles de piel de la
        % imagen.
        img = imread(files(i).folder + "/" + files(i).name);
        imgName = files(i).name;
        imgName = strsplit(imgName, '.');
        
        ideal_mask_path = "Dataset_cop/Training-Dataset/Masks-Ideal/" + imgName(1) + ".bmp";
        ideal_mask = imcomplement(imread(ideal_mask_path));
        
        % diezmado de la imagen
        [width, height, ~] = size(img);
        DIEZMADO = 10;
        img = imresize(img,[width/DIEZMADO,height/DIEZMADO],'Method','bilinear');
        ideal_mask = imresize(ideal_mask,[width/DIEZMADO,height/DIEZMADO],'Method','bilinear');
        
        % Devuelve las componentes L a b d ela imagen. último argumento:
        % true -> solo componentes correspondientes a piel
        % false -> componentes de toda la imagen 
        [L, a, b] = calc_hist_2D(img, ideal_mask, true);

        % Concatenamos los pixeles de piel de cada imagen con su array de
        % crominancia correspondiente
        L_arr = vertcat(L_arr, L);
        a_arr = vertcat(a_arr, a);
        b_arr = vertcat(b_arr, b);
end


% PLot del histograma 2D
SALTO = 1;
[N_cb,edges_cb] = histcounts(a_arr);
[N_cr,edges_cr] = histcounts(b_arr);

figure
hist3([a_arr, b_arr],{min(edges_cb):SALTO:max(edges_cb) min(edges_cr):SALTO:max(edges_cr)}, 'CdataMode','auto','FaceColor','interp')
title('A-B chrominance histogram'), ylabel('B'), xlabel('A'),
xlim([min(edges_cb) max(edges_cb)])
ylim([min(edges_cr) max(edges_cr)])

% xline(1.99,'-r','A_(min)');
% xline(23.583,'-r','A_(max)');
% 
% yline(-4.617,'-r','B_min');
% yline(30.929,'-r','B_max');

figure()
subplot(3,1,1)
L_hist = histogram(L_arr);
subplot(3,1,2)
A_hist = histogram(a_arr);
subplot(3,1,3)
B_hist = histogram(b_arr);
grid on


