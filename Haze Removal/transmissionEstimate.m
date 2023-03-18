function transmission = transmissionEstimate(im, A)
%4.1估计传输率
omega = 0.85; %保留景深感，保留少量的雾而设置的参数

%对有雾图的每一个颜色通道进行归一化
im3 = zeros(size(im));
for ind = 1:3 
    im3(:,:,ind) = im(:,:,ind)./A(ind);
end

transmission = 1-omega*darkChannel(im3);%计算出传输率
