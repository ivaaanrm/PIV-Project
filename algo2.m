clear all
close all

name = '0_A_hgr2B_id01_1';
img_path = "Dataset/Training-Dataset/Images/" + name + ".jpg";

img = imread(img_path);

yCbCr_img = rgb2ycbcr(img);

[width, height, channels] = size(YCbCr_img);

% y = yCbCr_img(:,:,1);
% cb = yCbCr_img(:,:,2);
% cr = yCbCr_img(:,:,3);

cb_max = 149.00;
cb_min = 136.00;
cr_max = 110.00;
cr_min = 122.00;

BW = zeros(witdh,height,1);

for c=1:width
    for r=1:height
        if ((yCbCr_img(r,c,2) >= cb_min) && (yCbCr_img(r,c,2) <= cb_max))
            
        end
    end
end



figure
imshow(BW)