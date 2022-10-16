clear all
close all

dinfo = dir('Dataset/Training-Dataset/Images/');

% Por cada imagen del directorio de entrenamiento calculamos el histograma
% 2D de de la imagen filtrada con los pixeles que corresponden a la piel.
% for K = 1 : length(dinfo)
for i = 1 : length(dinfo)
    if dinfo(i).isdir < 1
        imgName = dinfo(i).name;
        imgName = strsplit(imgName, '.');
        [cb_masked, cr_masked] = masked_hist_2D(imgName(1));
        hold on
        plot_2D_hist(imgName(1), cr_masked, cb_masked);
    end
end
