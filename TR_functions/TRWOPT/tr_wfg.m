function [f,Gradient] = tr_wfg(X,W,Z_v,r)
S=size(X);
N=numel(S);
Z=Zm2Zt(Zv2Zm(Z_v,S,r),r);
X_hat=coreten2tr(Z);
Y=W.*X;
Y_hat=W.*X_hat;
f=0.5*(norm(tensor(Y_hat-Y)))^2;
% gradient

Gradient=cell(N,1);
for n=1:N
    Z_ne=Z_neq(Z,n);
    Gradient{n}=tenmat_sb(Y_hat-Y,n)*tenmat_sb(Z_ne,2);
end
% vectorize cell & matrix mode gradient
Gradient=Zm2Zv(Gradient);
end