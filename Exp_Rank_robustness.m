% This demo compares TRLRF (proposed), TRALS (ICCV 2017), TRWOPT (APSIPA 2018) under
% different TR-rank which can show results of Figure 4 in our paper.

% addpath
currentFolder = pwd;
addpath(genpath(currentFolder));
% data preparation
img=double(imread('lena.bmp'));
X=img/255;
mr=0.80;
r_select=[4 6 8 10 12];
Lambda=[3 3 3 3 3];
I=numel(r_select);
S=size(X); N=ndims(X);
W=gen_W(S,mr);
RSE=zeros(3,I); PSNR=zeros(3,I);
img_set=cell(3,I);

%% exp
for i=1:5
    TR_rank=r_select(i);
    tic
    % TRLRF (Proposal)
    fprintf('------TRLRF ------ \n\n');
    maxiter=500;
    tol=1e-8;
    ro=1.015;
    K0=1e1;
    [X_out,~]=TRLRF(X,W,r_select(i)*ones(1,N),maxiter,K0,ro,Lambda(i),tol);
    RSE_TRLRF=RSE_fun(X,X_out,W);
    RSE(1,i)=RSE_TRLRF(1);
    X_out_img=reshape(X_out,size(img)); img_set{1,i}=X_out_img;
    PSNR(1,i) = PSNR_RGB(X_out_img(:,:,1:3)*255,double(img(:,:,1:3)*255));
    fprintf('------ Done! ------ \n\n');
    % TRALS
    % Wang Wenqi, et al.
    % "Efficient Low Rank Tensor Ring Completion." Computer Vision (ICCV), 2017
    fprintf('------TRALS ------ \n\n');
    para_TR.disp = 10;
    para_TR.r = r_select(i)*ones(1,N);   % Tensor Ring Rank
    para_TR.max_tot=1e-6;
    para_TR.max_iter=100;
    X_out = coreten2tr(TR_ALS(X, W, para_TR));
    X_out(W==1)=X(W==1);
    RSE_TRALS=RSE_fun(X,X_out,W);
    RSE(2,i)=RSE_TRALS(1);
    X_out_img=reshape(X_out,size(img)); img_set{2,i}=X_out_img;
    PSNR(2,i) = PSNR_RGB(X_out_img(:,:,1:3)*255,double(img(:,:,1:3)*255));
    fprintf('------ Done! ------ \n\n');
    % TRWOPT
    % Longhao Yuan, et al. 
    % "Higher-dimension Tensor Completion via Low-rank Tensor Ring Decomposition."
    % arXiv preprint arXiv:1807.01589 (2018).
    fprintf('------ TRWOPT ------ \n\n');
    maxiter_trwopt=200;
    X_out=WTR(X,W,r_select(i)*ones(1,N),maxiter_trwopt);
    X_out(W==1)=X(W==1);
    RSE_TRWOPT=RSE_fun(X,X_out,W);
    RSE(3,i)=RSE_TRWOPT(1);
    X_out_img=reshape(X_out,size(img)); img_set{3,i}=X_out_img;
    PSNR(3,i) = PSNR_RGB(X_out_img(:,:,1:3)*255,double(img(:,:,1:3)*255));
    fprintf('------ Done! ------ \n\n');
time_spent=toc
end
%% draw img_set
figure;
for j=1:I
    subtightplot(3,I,j); imshow(img_set{1,j});title('TRLRF')
    subtightplot(3,I,j+I); imshow(img_set{2,j});title('TRALS')
    subtightplot(3,I,j+2*I); imshow(img_set{3,j});title('TRWOPT')
end
RSE
%save img_rank_robust.mat