clear all
close all

dinfo = dir('Dataset/Training-Dataset/Images/');
% Por cada imagen del directorio de entrenamiento calculamos el histograma
% 2D de de la imagen filtrada con los pixeles que corresponden a la piel.
cb = [];
cr = [];
y= [];
for i = 1 : length(dinfo)
    if dinfo(i).isdir < 1
        
        % Obtenemos el nombre del fichero y calculamos el histigrama 2D de
        % las componentes de crominancia de los pixeles de piel de la
        % imagen.
        imgName = dinfo(i).name;
        imgName = strsplit(imgName, '.');
        [y_masked, cb_masked, cr_masked] = masked_hist_2D(imgName(1));
        
        % Concatenamos los pixeles de piel de cada imagen con su array de
        % crominancia correspondiente
        y = vertcat(y, y_masked);
        cb = vertcat(cb, cb_masked);
        cr = vertcat(cr, cr_masked);
    end
end

plot_2D_hist(cb, cr);


mac_cb = max(cb);
max_cr = max(cr);
min_cb = min(cb);
min_cr = min(cr);


