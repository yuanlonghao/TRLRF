clear all;clc; close all; warning off;
addpath Data_Source
addpath TensorRing
addpath tensorlab
filename = 'Result_Einstein';
mkdir(filename);
%% Original Data
load('Einstein.mat');
figure()
imshow(Data);
saveas(gcf, strcat(filename,'/Einstein_FullObserve.pdf'));
Data = double(Data);

%% Randomsampling Missing Entries
ObserveRatio = 0.1;
Data_Size = size(Data);
Omega = zeros(Data_Size);
Omega(randsample(prod(Data_Size), ObserveRatio*prod(Data_Size))) = 1;
Data_Missing = reshape(T2V(Data).* T2V(Omega), Data_Size);
figure()
imshow(uint8(Data_Missing));
saveas(gcf, strcat(filename,['/Einstein_ObservingRate' num2str(ObserveRatio) '.pdf']));

%% Complete Missing Data By TR
% TR Parameter
Reshape_Dim   = [6,10,10,6,10,10,3];
r = 20;
para_TR.max_tot = 10^-3;   
para_TR.max_iter= 300;     
para_TR.disp = 1;
para_TR.r = ones(length(Reshape_Dim), 1) * r;   % Tensor Ring Rank
%para_TR.r(end)=1; % if TT

% TR Completion
Utr = Completion_TR(reshape(Data_Missing, Reshape_Dim), reshape(Omega, Reshape_Dim), para_TR);
Data_Recover_TR = reshape(Ui2U(Utr), Data_Size);
% Plot recovered images
figure()
imshow(uint8(Data_Recover_TR));
saveas(gcf, strcat(filename,['/Einstein_Completion(TR)Rank' num2str(r) 'Err' num2str(norm(T2V(Data_Recover_TR-Data))/norm(T2V(Data))) '.pdf']));
