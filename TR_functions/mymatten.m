% from matrix to tensor
% 1 kolda mat, 2 tt mat, 3 tr mat
function X=mymatten(Xn,n,S,type)
N=numel(S);

if type==1
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
    
elseif type==2
    X=reshape(Xn,S);
    
else
Xn=reshape(Xn,[prod(S(n:end)),prod(S(1:n-1))]);
Xn=permute(Xn,[2,1]);
X=reshape(Xn,S);
end

end