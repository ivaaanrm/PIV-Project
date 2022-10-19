clear all
close all
addpath('Utils')

dinfo = dir('Dataset/Training-Dataset/Images/');

% Por cada imagen del directorio de entrenamiento calculamos el histograma
% 2D de de la imagen filtrada con los pixeles que corresponden a la piel.
% for K = 1 : length(dinfo)
cbr = [];
crr = [];
for i = 1 : length(dinfo)
    if dinfo(i).isdir < 1
        imgName = dinfo(i).name;
        imgName = strsplit(imgName, '.');
        [cb_masked, cr_masked] = masked_hist_2D(imgName(1));
        cbr = vertcat(cbr,cb_masked);
        crr = vertcat(crr, cr_masked);
    end
end

plot_2D_hist(cbr, crr);
