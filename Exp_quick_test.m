% Completion of a 256*256*3 image by TRLRF
% Addpath
currentFolder = pwd;
addpath(genpath(currentFolder));

% Load data
image=imread('lena.bmp');
X=double(image)/255;
mr=0.5; % missing rate
W=gen_W(size(X),mr);

% TRLRF
r=5*ones(1,3); % TR-rank 
maxiter=300; % maxiter 300~500
tol=1e-6; % 1e-6~1e-8
Lambda=5; % usually 1~10
ro=1.1; % 1~1.5
K=1e0; % 1e-1~1e0 
[X_hat,~,~]=TRLRF(X,W,r,maxiter,K,ro,Lambda,tol);

% Evaluation
RSE=RSE_fun(X,X_hat,W);
fprintf('Completion RSE is %.3f\n',RSE(1));
image_hat=uint8(X_hat*255);
figure;
subplot(1,3,1); imshow(image);title('Original');
subplot(1,3,2); imshow(uint8(255*W.*X));title('50% MISSING');
subplot(1,3,3); imshow(image_hat);title('Completion');