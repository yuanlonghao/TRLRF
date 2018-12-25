function X=tenmat2tensor(Xn,S,n)
N=numel(S);
if n==1
    S_new=S;
    P=1:N;
elseif n==N
    S_new=[S(N) S(1:N-1)];
    P=[2:N 1];
else
    S_new=[S(n) S(1:n-1) S(n+1:N)];
    P=[2:n 1 n+1:N];
end
X=permute(reshape(Xn,S_new),P);
end