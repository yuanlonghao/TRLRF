% mode-k unfolding of X (square bracket unfolding)
% Ik x Ik+1 ... IN I1...Ik-1
function X_sb_k=tenmat_sb(X,k)
S=size(X);
N=numel(S);
if k==1
    X_sb_k=reshape(X,[S(1),numel(X)/S(1)]);
elseif k==N
     X_sb_k=reshape(X,[numel(X)/S(N),S(N)]);
     X_sb_k=permute( X_sb_k,[2,1]); % necessary???????????????
else
X=reshape(X,[prod(S(1:k-1)),numel(X)/prod(S(1:k-1))]);
X=permute(X,[2,1]);
X_sb_k=reshape(X,[S(k),numel(X)/S(k)]);
end
end