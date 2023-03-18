function A = atmLight(im, JDark)
%4.3中估计大气光 A
% 大气光的颜色非常接近天空的颜色
% 所以选择所以只需选择暗通道图像(JDark)中中最接近1的前几个像素
% 通过对暗通道图像中前0.1%最亮像素取平均即可
% 获取图片大小
[height, width, ~] = size(im);
imsize = width * height;
numpx = floor(imsize/1000); % 图像中前0.1%的像素个数
JDarkVec = reshape(JDark,imsize,1); %暗通道图像像素向量化
ImVec = reshape(im,imsize,3);  %原图图像像素向量化
% 根据像素值对暗通道图像中的像素进行排序
[JDarkVec, indices] = sort(JDarkVec); 
indices = indices(imsize-numpx+1:end); % 取出最亮的0.1%个像素值索引
atmSum = zeros(1,3);
for ind = 1:numpx
    atmSum = atmSum + ImVec(indices(ind),:);%累加求和
end
A = atmSum / numpx;%求平均值