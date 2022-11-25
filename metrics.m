function [tp, tn, fn, fp, precision, recall] = metrics(masked, ideal)
%     tp = 0;
%     fp = 0;
%     tn = 0;
%     fn = 0;
%     [width, height, ~] = size(masked);
%     for x=1:width
%         for y=1:height
%             if masked(x,y) == 1
%                 if ideal(x,y) == 1
%                     tp = tp+1;
%                 elseif ideal(x,y) == 0
%                     fp = fp+1;
%                 end
%             end
%             if masked(x,y) == 0
%                 if ideal(x,y) == 1
%                     fn = fn+1;
%                 elseif ideal(x,y) == 0
%                     tn = tn+1;
%                 end
%             end
%         end
%     end
    
    mask_arr = reshape(masked.',1,[]);
    ideal_arr = reshape(ideal.',1,[]);
    cm = confusionmat(mask_arr,ideal_arr);
    tp = cm(2,2);
    tn = cm(1,1);
    fn = cm(1,2);
    fp = cm(2,1);
    
    precision = tp/(tp+fp);
    recall = tp/(tp+fn);

end