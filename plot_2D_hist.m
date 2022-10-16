function plot_2D_hist(name, cr_masked, cb_masked)
    img_path = "Dataset/Training-Dataset/Images/" + name + ".jpg";
   
% Mostramos el histograma 2D de los canales cb y cr filtrados
%     figure
%     subplot(1,2,1)
%     imshow(img_path)
%     subplot(1,2,2)
    histogram2(cb_masked, cr_masked, 'FaceColor', 'flat');
    title('cb-cr masked Histogram'), ylabel('cr'), xlabel('cb'), xlim([80, 150]), ylim([100,180]); 
end