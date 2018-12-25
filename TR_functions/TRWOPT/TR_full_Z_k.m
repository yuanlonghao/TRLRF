% formula 21 of <Tensor Ring Decomposition>
% Z is cell mode tensor cores 

function [Formula_l,Formula_r]=TR_full_Z_k(Z,k)
N=numel(Z);
Formula_l=double(tenmat(Z{k},2));
[kl,kr]=Z_kmode_devide(Z,k);
if k==1
    Z_no_equal_k=tenmat_sb(kr,2);
    Formula_r=Z_no_equal_k';
elseif k==N
     Z_no_equal_k=tenmat_sb(kl,2);
     Formula_r=Z_no_equal_k';
else
kl1=reshape(kl,[size(kl,1),numel(kl)/size(kl,1)]);
kr1=reshape(kr,[numel(kr)/size(kr,3),size(kr,3)]);
P=kr1*kl1;
Z_no_equal_k=reshape(P,[size(kr,1),numel(P)/(size(kr,1)*size(kl,3)),size(kl,3)]);
Z_no_equal_k=permute(Z_no_equal_k,[2,3,1]);
Z_no_equal_k=reshape(Z_no_equal_k,[numel(P)/(size(kr,1)*size(kl,3)),size(kr,1)*size(kl,3)]);
Formula_r=Z_no_equal_k';
end
end
