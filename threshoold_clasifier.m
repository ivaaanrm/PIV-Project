function [BW] = threshoold_clasifier(yCbCr_img)
    
	[width, height, ~] = size(yCbCr_img);

    y_min = 75;
    
    cb_max = 127.00;
    cb_min = 77.00;
    
    cr_max = 153.00;
    cr_min = 125.00;

    BW = zeros(width,height,1);
    for x=1:width
        for y=1:height
            if (yCbCr_img(x,y,2) >= y_min)
                if ((yCbCr_img(x,y,2) >= cb_min) && (yCbCr_img(x,y,2) <= cb_max))
                    if ((yCbCr_img(x,y,3) >= cr_min) && (yCbCr_img(x,y,3) <= cr_max))
                        BW(x,y) = 1;
                    end
                end
            end
        end
    end

end