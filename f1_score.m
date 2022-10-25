function [f1score] = f1_score(precision, recall)

    f1score = (2*precision*recall)/(precision+recall);

end