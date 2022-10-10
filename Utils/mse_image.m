function mseval = mse_image(im1,im2)
% MSE Averaged square error between two images of intensity values 
%
%  mseval=mse(im1,im2) returns the averaged square error between the 
%  pixels of two images of intensity (grayscale) values. The mean 
%  of the error is discarded
%
%  See also PSNR
%
% JRC Feb98, josep@gps.tsc.upc.es

if (nargin~=2)

   error('Sintax: mse_value=mse(input_image1, input_image2)');

end


%temp=im1-im2;
%temp=temp-mean2(temp);	% discards DC error
%mseval= mean2(temp.^2);
mseval= std2(im1-im2)^2;

return
