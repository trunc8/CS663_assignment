%% MyMainScript
cd ..;
mkdir images/;
cd codes/;
tic;
images = [imread("../data/barbara.png"), imread("../data/TEM.png"), imread("../data/canyon.png"), ...
    imread("../data/retina.png"), imread("../data/church.png"), imread("../data/chestXray.png"),...
    imread("../data/statue.png")];
%% Part (a) Foreground Mask
tic;
img = images(7); % imread("../data/statue.png");
[mask, masked_image] = myForegroundMask(img);
subplot(1,3,1), showImage(img, "Original Image", 200);
subplot(1,3,2), showImage(mask, "Binary Mask", 200);
subplot(1,3,3), showImage(masked_image, "Masked Image", 200);
cd ../images/;
save mask.mat mask;
save masked_image.mat masked_image;
cd ../codes;
pause(2);
toc;

%% Part (b) Linear Contrast Stretching
tic;

toc;

%% Part (c) Histogram Equalisation
tic;

toc;

%% Part (d) Histogram Matching
tic;

toc;

%% Part (e) Contrast Limited Adaptive Histogram Equalisation
tic;
for i=1:length(images)
    img = images(i);
    windowsize = [30 30];
    windowsizelarge = [100 100];
    windowsizesmall = [5 5];
    cliplimit = 4;
    subplot(1,2,1), showImage(img, "Original Image", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsize, cliplimit), "CLAHE Enhanced Image", 200);
    pause(2);
    subplot(1,2,1), showImage(myCLAHE(img, windowsizesmall, cliplimit), "Larger Window Size 100x100", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsizesmall, cliplimit), "Smaller Window Size 5x5", 200);
    pause(2);
    subplot(1,2,1), showImage(myCLAHE(img, windowsize, cliplimit), "CLAHE Enhanced Image with Initial Clip Limit", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsize, cliplimit/2), "CLAHE Enhanced Image with Clip Limit Halved", 200);
    pause(2);
end
toc;
toc;
