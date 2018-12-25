%%
addpath tensorlab/

I = [10,10,10,10];
R = 3;
r = [R*ones(1,3),2];
d = length(I);

Ui = cell(d,1);
Ui{1} = randn(r(4),I(1), r(1));
Ui{2} = randn(r(1),I(2), r(2));
Ui{3} = randn(r(2),I(3), r(3));
Ui{4} = randn(r(3),I(4), r(4));
U = Ui2U(Ui);

para_TR.max_tot     = 10^-10; para_TR.max_iter      =300;   para_TR.r=r;                  para_TR.disp =  1;
Average_Times = 1;
ObsRatio = 0.8;

P_Omega = zeros(size(U));
P_Omega( randsample( prod(I), round(ObsRatio * prod(I))) )=1; 
U_Omega = U.*P_Omega; 

tic
Utr_TR = Completion_TR(U_Omega, P_Omega, para_TR);
time_TR=toc
Recover_Error_TR = norm(T2V(Ui2U(Utr_TR) -U))/norm(T2V(U));