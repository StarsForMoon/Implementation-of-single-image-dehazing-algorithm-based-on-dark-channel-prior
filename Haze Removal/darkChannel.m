function JDark = darkChannel(im2)
%根据图像得到图像的暗通道图像
[height, width, ~] = size(im2);

patchSize = 15; %设置参数Patch Size大小为15
padSize = floor(patchSize/2); %将填充数组的padSize设置为Patch Size的一半左右

JDark = zeros(height, width); % 返回的暗通道图像
imJ = padarray(im2, [padSize padSize], Inf); % 用无穷大初始化填充数组

for j = 1:height
    for i = 1:width
        patch = imJ(j:(j+patchSize-1), i:(i+patchSize-1),:);
        %求取最小值作为暗通道中的值
        JDark(j,i) = min(patch(:));%局部区域内的暗通道是该区域内所有通道的最小值
     end
end
