function psnrval = psnr_image(im1,im2)
% PSNR Peak signal to noise ratio between two images of intensity values 
%
%  psnrval=mse(im1,im2) returns the peak signal to noise ratio between the 
%  pixels of two images of intensity (grayscale) values between 0.0-1.0
%
%  See also mse_image
%
% JRC Feb98, josep@gps.tsc.upc.es.
% TG Jun16.

if (nargin~=2)
   error('Sintax: psnr_value=psnr(input_image1, input_image2)');
end

if (max(max(im1))>1)||(max(max(im2))>1)
    error('the pixels of two images of intensity (grayscale) values should be between 0.0-1.0')
end

psnrval= -10*log10(mse_image(im1,im2));

