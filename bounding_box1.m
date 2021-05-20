function [ROIbox,maskBox]=bounding_box1(volume) 

mask=logical(volume);
mask_ind=find(mask);
[mask_row,mask_col,mask_slc] = ind2sub(size(mask),mask_ind);
boxBound = [min(mask_row) , max(mask_row) ; ...
                min(mask_col) , max(mask_col) ; ...
                min(mask_slc) , max(mask_slc) ];
maskBox = mask(boxBound(1,1):boxBound(1,2),boxBound(2,1):boxBound(2,2),boxBound(3,1):boxBound(3,2));
ROIbox = volume(boxBound(1,1):boxBound(1,2),boxBound(2,1):boxBound(2,2),boxBound(3,1):boxBound(3,2));
