function[img_vol_subvol]=boundingBox(img_vol)

ROI_full_logical=logical(img_vol);
ROI_full_ind = find(ROI_full_logical);
[ROI_full_row,ROI_full_col,ROI_full_slc] = ind2sub(size(ROI_full_logical),ROI_full_ind);
bounding_box = [min(ROI_full_row) , max(ROI_full_row) ; ...
                min(ROI_full_col) , max(ROI_full_col) ; ...
                min(ROI_full_slc) , max(ROI_full_slc) ];

img_vol_subvol = img_vol(bounding_box(1,1):bounding_box(1,2) , ...
                         bounding_box(2,1):bounding_box(2,2) , ...
                         bounding_box(3,1):bounding_box(3,2) );      
                     
                     