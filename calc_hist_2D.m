function [L,a,b] = calc_hist_2D(img,mask,full)
%CALC_HIST_2D Summary of this function goes here
%   Detailed explanation goes here

    % Initialize output masked image based on input image.
    
    maskedLABImage = rgb2lab(img);

    if full
        % Set background pixels where BW is false to zero.
        maskedLABImage(repmat(~mask,[1 1 3])) = 0;
    end

    L_ = maskedLABImage(:,:,1);
    a_ = maskedLABImage(:,:,2);
    b_ = maskedLABImage(:,:,3);
    
    L = reshape(L_.',1,[]);
    a = reshape(a_.',1,[]);
    b = reshape(b_.',1,[]);
    
    if full
        L(L==0)=[];
        a(a==0)=[];
        b(b==0)=[];
    end

    % array transpose
    L = L.';
    a = a.';
    b = b.';
    

end

