clc;
clear;
img=imread(".\Dataset\fog.jpg");
img=double(img)./255;
J = deHaze(img);
figure;
subplot(1,2,1);
imagesc(img)
title '原始图像'
axis image off;
subplot(1,2,2);
imagesc(J)
title '去雾图像'
axis image off;
