function H = Entropy(imain)

% ENTROPY Entropy in bits/pixel of intensity images
%
%  H=entropy(imain) returns the entropy of the intensity image 
%  imain using imhist.
%
%  See also IMHIST
%
% JRC Feb98, josep@gps.tsc.upc.es
% TG Mar16

if (nargin~=1)
   error('Sintax: Entropy(input_image)');
end

[counts,~]=imhist(imain);
p=counts/sum(counts);
p(p==0)=[];
H=-sum(p.*log2(p));




