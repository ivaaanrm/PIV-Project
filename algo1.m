name = '5_P_hgr1_id05_3';
img_path = "Dataset/Training-Dataset/Images/" + name + ".jpg";
mask_path = "Dataset/Training-Dataset/Masks-Ideal/" + name + ".bmp";

mask = imread(mask_path);
mask = im2uint8(mask);
img = imread(img_path);

figure
imshow(mask);
figure
imshow(img);
ycbcr_img = rgb2ycbcr(img);
imshow(ycbcr_img);

%lab_img = rgb2lab(img);
%figure
%imshow(lab_img);

cb = ycbcr_img(:,:,2);
cr = ycbcr_img(:,:,3);

cb_array = reshape(cb.',1,[]);
cr_array = reshape(cr.',1,[]);
mask_array_log = reshape(mask.',1,[]);
mask_array = mask_array_log;


cb_masked = cb_array .* mask_array;
cr_masked = cr_array .* mask_array;

data = [cb_array(:), cr_array(:)];

figure
histogram2(cb_array, cr_array, 'FaceColor', 'flat');
title('cb-cr Histogram'), ylabel('cr'), xlabel('cb');

figure
histogram2(cb_masked, cr_masked, 'FaceColor', 'flat');
title('cb-cr masked Histogram'), ylabel('cr'), xlabel('cb');

