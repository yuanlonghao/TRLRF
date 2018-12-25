function X=X_sb_k2X(X_sb_k,X,k)
S=size(X);
X_sb_k=reshape(X_sb_k,[prod(S(k:end)),prod(S(1:k-1))]);
X_sb_k=permute(X_sb_k,[2,1]);
X=reshape(X_sb_k,S);
end