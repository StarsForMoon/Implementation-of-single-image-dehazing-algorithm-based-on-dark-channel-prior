function J = getRadiance(A,im,transmission)
t0 = 0.1;%设置传输率下界
J = zeros(size(im));
for ind = 1:3
   J(:,:,ind) =  (im(:,:,ind) - A(ind))./max(transmission,t0)+A(ind); 
end
%J = J./(max(max(max(J))));