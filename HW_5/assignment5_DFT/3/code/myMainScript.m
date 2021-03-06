%% Solution to A5 - Q3
clear;
close all;

%report
import mlreportgen.report.*
import mlreportgen.dom.*

cd ../report/
R = Report('Report 5.3: Notch filter', 'pdf');
open(R)
cd ../code/

T = Text("Assignment 5: Discrete Fourier Transform");
T.Bold = true;
T.FontSize = '26';
headingObj = Heading1(T);
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading5("Tezan Sahu [170100035] & Siddharth Saha [170100025]");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading6("Due Date: 03/11/2019");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading3("Q3: Notch filter");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

sec = Section;
T = Text("Output Images");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;
%report

tic;
%% Your code here
cd ../data;
load("image_low_frequency_noise.mat");
cd ../code;

fig1 = figure(1); imshow(Z, [min(Z(:)) max(Z(:))]); 
title('Original Image');
pause(1);

%report
caption = Paragraph("Fig 1: Original Image");
caption.Style = {HAlign('center')};

add(sec, Figure(fig1))
add(sec, caption);
%report

Z = padarray(Z,[128 128],0);
FZ = fftshift(fft2(Z));
lFZ = log(abs(FZ)+1);
fig2 = figure(2); imshow(lFZ, [min(lFZ(:)) max(lFZ(:))]); colormap('jet'); colorbar;
title('Original Fourier Transform (Log Magnitude)');
% impixelinfo;
pause(1);
%report
caption = Paragraph("Fig 2: Log Magnitude of Fourier Transform");
caption.Style = {HAlign('center')};

add(sec, Figure(fig2))
add(sec, caption);
%report

% Interfering frequencies
f1 = [237 247];
f2 = [278 267];
r = 10; % radius
H = ones(512);
% Constructing ideal notch reject filter
for i=1:size(H,1)
    for j=1:size(H,2)
        if ((f1(1)-i)^2+(f1(2)-j)^2) <= r^2
            H(i, j) = 0;
        end
        if ((f2(1)-i)^2+(f2(2)-j)^2) <= r^2
            H(i, j) = 0;
        end
    end
end
% H(f1(1)-r:f1(1)+r, f1(2)-r:f1(2)+r) = 0;
% H(f2(1)-r:f2(1)+r, f2(2)-r:f2(2)+r) = 0;

new_FZ = FZ.*H;
new_lFZ = log(abs(new_FZ)+1);
fig3 = figure(3); imshow(new_lFZ, [min(lFZ(:)) max(lFZ(:))]); colormap('jet'); colorbar;
title('Fourier Transform after applying Notch Filter');
pause(1);
%report
caption = Paragraph("Fig 3: Fourier Transform after applying Notch Filter (each of radius = 10)");
caption.Style = {HAlign('center')};

add(sec, Figure(fig3))
add(sec, caption);
%report

new_Z = ifft2(ifftshift(new_FZ));
final_img = new_Z(129:384, 129:384); % Removed padding
fig4 = figure(4); imshow(final_img, [ min(abs(final_img(:))) max(abs(final_img(:))) ]);
title('Restored Image');
%report
caption = Paragraph("Fig 4: Restored Image");
caption.Style = {HAlign('center')};

add(sec, Figure(fig4))
add(sec, caption);

add(R, sec)
close(R)
%report
toc; % Nearly 10 sec
