clear all;clc; close all; warning off;
addpath tight_subplot
addpath TensorRing
addpath tensorlab
addpath Data_Source
filename = 'Result_YaleFace'; 
mkdir(filename);

%%
load YaleBCrop025.mat
Data = reshape(Y, 48,42,64,38);
clear I s Ind Y
figure()
ha = tight_subplot(1,10,[.01 .03],[.1 .01],[.01 .01]);
% Show 10 Images of the selected person
person = 1; % 1-38, one of the 38 persons
for i = 1:10; 
    axes(ha(i));
    imshow(Data(:,:,i, person), [0,255]); 
end
saveas(gcf, strcat(filename, '/YaleFace_Full.pdf'));

%% Show Missing Images
ObserveRatio = 0.1;
Data_Size = size(Data);
Omega = zeros(Data_Size);
Omega(randsample(prod(Data_Size), round(ObserveRatio*prod(Data_Size)))) = 1;
Data_Missing = reshape(T2V(Data).* T2V(Omega), Data_Size);
figure()
ha = tight_subplot(1,10,[.01 .03],[.1 .01],[.01 .01]);
for i = 1:10; 
    axes(ha(i));
    imshow(Data_Missing(:,:,i, person), [0,255]); 
end
saveas(gcf, strcat(filename,['/YaleFace_ObserveRatio_' num2str(ObserveRatio) '.pdf']));
%%
Reshape_Dim  = [6,8,   6,7,    8,8,   19,2];
r = 2;
para_TR.max_tot = 10^-4;   
para_TR.max_iter= 300;     
para_TR.disp = 1;
para_TR.r = r * ones(length(Reshape_Dim), 1);
%para_TR.r(end)=1; % if TT

Utr = Completion_TR(reshape(Data_Missing, Reshape_Dim), reshape(Omega, Reshape_Dim), para_TR);
Data_Recover_TR = reshape(Ui2U(Utr), Data_Size);
    
figure()
ha = tight_subplot(1,10,[.01 .03],[.1 .01],[.01 .01]);
for i = 1:10; 
    axes(ha(i));
    imshow(Data_Recover_TR(:,:,i, person), [0,255]); 
end
ImageName = ['/YaleFace_Completion(TR)Rank:' num2str(r), 'Err' num2str(norm(T2V(Data_Recover_TR-Data))/norm(T2V(Data))) '.pdf'];
saveas(gcf, strcat(filename,ImageName));