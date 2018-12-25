clear all;clc; close all; warning off;
addpath Data_Source
addpath PlotFunction
addpath tensorlab
addpath TensorRing
filename = 'Result_Gunshot'; 
mkdir(filename);

%% Original Data
load VideoData.mat
Data2Video(Data, strcat(filename,'/GunShot_Full'));

%% Random Sampling Missing Entries
ObserveRatio = 0.1;
Data_Size = size(Data);
Omega = zeros(Data_Size);
Omega(randsample(prod(Data_Size), round(ObserveRatio*prod(Data_Size)))) = 1;
Data_Missing = reshape(T2V(Data).* T2V(Omega), Data_Size);
Data2Video(Data_Missing, strcat(filename, '/GunShot_Missing'));

%%
Reshape_Dim  = [5,2,5,2,    13,2,5,2,   3,  5,17];
r = 2;
para_TR.max_tot = 10^-4;   
para_TR.max_iter= 300;     
para_TR.disp = 1;
para_TR.r = r * ones(length(Reshape_Dim), 1);
% para_TR.r(end)=1; % if TT
% TR Completion
Utr = Completion_TR(reshape(Data_Missing, Reshape_Dim), reshape(Omega, Reshape_Dim), para_TR);
Data_Recover_TR = reshape(Ui2U(Utr), Data_Size);
VideoName = strcat(filename, ['/Rank' num2str(r), '_Error' num2str(norm(T2V(Data_Recover_TR-Data))/norm(T2V(Data)))]);
Data2Video(Data_Recover_TR, VideoName);  