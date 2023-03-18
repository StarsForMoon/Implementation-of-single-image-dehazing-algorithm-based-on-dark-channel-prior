clc;
clear;

%导入单个图像，并作归一化处理
img=imread(".\Dataset\m2.jpg");
img=double(img)./255;

%3.得到Dark Channel图像

%根据图像得到图像的暗通道图像
% 获取图片大小
[height, width, ~] = size(img);

%设置参数Patch Size大小为15
patchSize = 15; 

 %将填充数组的padSize设置为Patch Size的一半左右
padSize = floor(patchSize/2);

 % 返回的暗通道图像
JDark = zeros(height, width);

% 用无穷大初始化填充数组
imJ = padarray(img, [padSize padSize], Inf); 

%局部区域内的暗通道是该区域内所有通道的最小值
for j = 1:height
    for i = 1:width
        patch = imJ(j:(j+patchSize-1), i:(i+patchSize-1),:);
        %求取最小值作为暗通道中的值
        JDark(j,i) = min(patch(:));
     end
end

% 4.3中估计大气光 A

% 大气光的颜色非常接近天空的颜色
% 所以选择所以只需选择暗通道图像(JDark)中中最接近1的前几个像素
% 通过对暗通道图像中前0.1%最亮像素取平均即可

% 获取图片大小
[height, width, ~] = size(img);
imsize = width * height;

% 图像中前0.1%的像素个数
numpx = floor(imsize/1000);
% 暗通道图像像素向量化
JDarkVec = reshape(JDark,imsize,1); 
% 原图图像像素向量化
ImVec = reshape(img,imsize,3); 

% 根据像素值对暗通道图像中的像素进行排序
[JDarkVec, indices] = sort(JDarkVec); 
% 取出最亮的0.1%个像素值索引
indices = indices(imsize-numpx+1:end); 

atmSum = zeros(1,3);
for ind = 1:numpx
    atmSum = atmSum + ImVec(indices(ind),:);%累加求和
end
%求平均值作为大气光
A = atmSum / numpx;

%4.1估计传输率
% 保留景深感，保留少量的雾而设置的参数
omega = 0.90;

%对有雾图的每一个颜色通道进行归一化
I = zeros(size(img));
for ind = 1:3 
    I(:,:,ind) = img(:,:,ind)./A(ind);
end

%计算出传输率
transmission = 1-omega*darkChannel(I);

%设置传输率下界
t0 = 0.1;
J = zeros(size(img));

%计算场景辐照度
for ind = 1:3
   J(:,:,ind) =  (img(:,:,ind) - A(ind))./max(transmission,t0)+A(ind); 
end

%结果展示
figure;
%原图
subplot(1,2,1);
imshow(img)
title '原图'
axis image off;
%去雾图
subplot(1,2,2);
imshow(J)
title '去雾图'
axis image off;
% %增强图
% subplot(1,3,3);
% img_enhanced=histeq(J);
% imshow(img_enhanced);
% title '增强去雾图'
% axis image off;


