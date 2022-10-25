clear all

files = dir(['Masks/', '/*.bmp']);

tp_ = 0;
tn_ = 0;
fn_ = 0;
fp_ = 0;
f1scores = [];

for i = 1 : length(files)
    imgName = files(i).name;
    imgName = strsplit(imgName, '.');

    pred_mask_path = "Masks/" + imgName(1) + ".bmp";
    ideal_mask_path = "Dataset/Training-Dataset/Masks-Ideal/" + imgName(1) + ".bmp";

    pred_mask = imread(pred_mask_path);
    ideal_mask = imcomplement(imread(ideal_mask_path));

    % ************ Metricas *********** %
    [tp, tn, fn, fp, prec, rec] = metrics(logical(pred_mask), ideal_mask);
    tp_ = tp_ + tp;
    fp_ = fp_ + fp;
    fn_ = fn_ + fn;
%     f1 = f1_score(prec, rec);
%     f1scores = vertcat(f1scores, f1);
    
end

% Calculo del F1 Score total
precision = tp_/(tp_+fp_);
recall = tp_/(tp_+fn_);
F1score_total = f1_score(precision, recall);
F1score_total
