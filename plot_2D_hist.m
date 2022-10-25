function plot_2D_hist(cr_masked, cb_masked)
   
% Mostramos el histograma 2D de los canales cb y cr filtrados
%     img_path = "Dataset/Training-Dataset/Images/" + name + ".jpg";
%     subplot(1,2,1)
%     img = imread(img_path);
%     ycbcr_img = rgb2ycbcr(img);
%     imshow(ycbcr_img)
%     title(['Image %s', name])
    SALTO = 4;
    [N_cb,edges_cb] = histcounts(cb_masked);
    [N_cr,edges_cr] = histcounts(cr_masked);
    
%     subplot(1,2,2)
    figure
    hist3([cb_masked, cr_masked],{0:SALTO:max(edges_cb) 0:SALTO:max(edges_cr)}, 'CdataMode','auto','FaceColor','interp')
    title('cb-cr masked Histogram'), ylabel('cr'), xlabel('cb'),
    xlim([min(edges_cb) max(edges_cb)])
    ylim([min(edges_cr) max(edges_cr)])
end