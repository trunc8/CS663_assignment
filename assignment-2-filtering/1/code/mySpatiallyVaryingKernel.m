function [newImg] = mySpatiallyVaryingKernel(img, d_thres)
%MYSPATIALLYVARYINGKERNEL Summary of this function goes here
%   Detailed explanation goes here
chan = size(img, 3);
img = im2double(img);
newImg = double(img);
img_g = rgb2gray(img);

mask = zeros(size(img_g));
row = 225;
col = 405;
mask(row:end-row, col:end-col) = 1;
%     imshow(mask)
%     title('Initial Contour Location')
%     pause(1)

img_mask = activecontour(img_g, mask, 900); % Gets the foreground mask
D = bwdist(img_mask); % Distance
%     imshow(img_mask)
%     title('Segmented Image')
%     pause(1)

H = fspecial('disk', d_thres); % Disc mask
blurred = imfilter(img, H, 'replicate'); % Convolves
%     imshow(blurred)
%     title('Blurred Image')
%     pause(1)

for i=1:1:chan
    newImg(:,:,i) = zeros(size(img_mask));
    newImg(:,:,i) = immultiply(img_mask, img(:,:,i));
    bg_mask = ones(size(img_mask)) - img_mask; % background mask
    newImg(:,:,i) = newImg(:,:,i) + immultiply(bg_mask, blurred(:,:,i));
    for D_row=1:size(D, 1)
        for D_col = 1:size(D, 2)
            d_local = floor(double(D(D_row, D_col)));
            if d_local < d_thres && d_local > 0
                H_local = fspecial('disk', d_local);
%                 class(H_local)
%                 size(H_local)
%                 pause(2)
                rows = round(mod((floor(D_row-d_local)-1:ceil(D_row+d_local)-1),size(D,1))+1);
                cols = round(mod((floor(D_col-d_local)-1:ceil(D_col+d_local)-1),size(D,2))+1);
                A = img(rows, cols, i);
%                 class(A)
%                 size(A)
                newImg(D_row, D_col,i)= sum(sum(immultiply(H_local,A)));
            end
        end
    end
end

    imshow(newImg)
    title('Masked Blur')
    pause(1)

