clear all

files = dir(['Fingers/', '/*.txt']);

preds_ = [];
refs_ = [];

aciertos = 0;

for i = 1 : length(files)
    % path de las máscaras
    imgName = files(i).name;

    % valor de referencia
    ref = strsplit(imgName, '_');
    ref = str2num(['uint8(',ref{1},')']);

    % Leer el numero
    path = "Fingers/"+imgName;
    fileID = fopen(path,'r');
    formatSpec = '%d';
    pred = fscanf(fileID,formatSpec);
    fclose(fileID);

    preds_ = vertcat(preds_,pred);
    refs_ = vertcat(refs_, ref);

    if pred == ref
        aciertos = aciertos + 1;
    end
    
end

%% Results

% Accuracy
accuracy = aciertos/length(refs_);
accuracy




% cm = confusionmat(uint8(preds_),uint8(refs_));
% tp = cm(2,2);
% tn = cm(1,1);
% fn = cm(1,2);
% fp = cm(2,1);
% 
% precision = tp/(tp+fp);
% recall = tp/(tp+fn);


% Calculo del F1 Score total
% precision = tp/(tp+fp);
% recall = tp/(tp+fn);
% F1score_total = (2*precision*recall)/(precision+recall);
% F1score_total
