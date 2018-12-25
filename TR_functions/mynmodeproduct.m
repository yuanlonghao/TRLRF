% n-mode product of a tensor and a matrix
function X_out=mynmodeproduct(X,A,n)
S=size(X);
S(n)=size(A,1);
Yn=A*mytenmat(X,n,1);
X_out=mymatten(Yn,n,S,1);
end