clear all

files = dir(['Masks/', '/*.bmp']);

tp_ = 0;
tn_ = 0;
fn_ = 0;
fp_ = 0;

for i = 1 : length(files)
    % path de las máscaras
    imgName = files(i).name;
    imgName = strsplit(imgName, '.');   
    pred_mask_path = "Masks/" + imgName(1) + ".bmp";
    ideal_mask_path = "Dataset/Training-Dataset/Masks-Ideal/" + imgName(1) + ".bmp";
    
    % Lectura de las máscaraas
    pred_mask = imread(pred_mask_path);
    ideal_mask = imcomplement(imread(ideal_mask_path));

    % Cálculo de las métricas
    [tp, tn, fn, fp, prec, rec] = metrics(logical(pred_mask), ideal_mask);
    tp_ = tp_ + tp;
    fp_ = fp_ + fp;
    fn_ = fn_ + fn;
end

% Calculo del F1 Score total
precision = tp_/(tp_+fp_);
recall = tp_/(tp_+fn_);
F1score_total = (2*precision*recall)/(precision+recall);
F1score_total
