function imaout = Equalize_Histogram(imain)
% ECUALIZE_HISTOGRAM Discrete histogram equalization of intensity images
%
%  imaout = ecualize_histogram(imain) returns the equalized version of the 
%  intensity image imain using histeq.
%
%  See also HISTEQ
%
% JRC Feb98, josep@gps.tsc.upc.es

if (nargin~=1)

   error('Sintax: ecualize_histogram(input_image)');
end


[counts,~]=imhist(imain);
C=size(find(counts));
imaout=histeq(imain,C(1,1));

return



