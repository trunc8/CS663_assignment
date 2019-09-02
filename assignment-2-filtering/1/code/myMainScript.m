%% MyMainScript

tic;
%% Your code here
flower = imread('../data/flower.jpg');
bird = imread('../data/bird.jpg');

% For bird ->
d_thres = 40;
r_min = 65;
r_max = 215;
c_min = 150;
c_max = 280;
[D, img_mask, bg_mask, img] = mySpatiallyVaryingKernel(bird, d_thres, r_min, r_max, c_min, c_max);
foreground = double(img);
background = double(img);
chan = size(img, 3);
for i=1:chan
   foreground(:,:,i) = immultiply(img_mask, img(:,:,i));
   background(:,:,i) = immultiply(bg_mask, img(:,:,i));
end
subplot(1,3,1);
imshow(img_mask);
title('a) Mask M');
subplot(1,3,2);
imshow(foreground);
title('b) Foreground');
subplot(1,3,3);
imshow(background);
title('c) Background');

imwrite(img_mask, '../images/bird_mask.png');
imwrite(foreground, '../images/bird_foreground.png');
imwrite(background, '../images/bird_background.png');
pause(2);
close;

contour(flipud(D), 'ShowText', 'on');
saveas(gcf, '../images/bird_contour.png');
pause(2);

fspecial('disk', round(0.2*d_thres))
pause(2);
fspecial('disk', round(0.4*d_thres))
pause(2);
fspecial('disk', round(0.6*d_thres))
pause(2);
fspecial('disk', round(0.8*d_thres))
pause(2);
fspecial('disk', round(d_thres))
pause(2);

imshow(img);
title('Spatially varying blurred image');
imwrite(img, '../images/bird_blurred.png');
pause(2);

% For flower ->
d_thres = 20;
r_min = 75;
r_max = 650;
c_min = 230;
c_max = 770;
[D, img_mask, bg_mask, img] = mySpatiallyVaryingKernel(flower, d_thres, r_min, r_max, c_min, c_max);
foreground = double(img);
background = double(img);
chan = size(img, 3);
for i=1:chan
   foreground(:,:,i) = immultiply(img_mask, img(:,:,i));
   background(:,:,i) = immultiply(bg_mask, img(:,:,i));
end
subplot(1,3,1);
imshow(img_mask);
title('a) Mask M');
subplot(1,3,2);
imshow(foreground);
title('b) Foreground');
subplot(1,3,3);
imshow(background);
title('c) Background');
imwrite(img_mask, '../images/flower_mask.png');
imwrite(foreground, '../images/flower_foreground.png');
imwrite(background, '../images/flower_background.png');
pause(2);
close;

contour(flipud(D), 'ShowText', 'on');
saveas(gcf, '../images/flower_contour.png');
pause(2);

fspecial('disk', round(0.2*d_thres))
pause(2);
fspecial('disk', round(0.4*d_thres))
pause(2);
fspecial('disk', round(0.6*d_thres))
pause(2);
fspecial('disk', round(0.8*d_thres))
pause(2);
fspecial('disk', round(d_thres))
pause(2);

imshow(img);
title('Spatially varying blurred image');
imwrite(img, '../images/flower_blurred.jpg');
pause(2);
toc;
