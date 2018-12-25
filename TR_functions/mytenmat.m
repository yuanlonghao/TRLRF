% from tensor to matrix
% 1 kolda mat, 2 tt mat, 3 tr mat
function Xn=mytenmat(X,n,type)
S=size(X);N=numel(S);
if type==1 % the In x I1...In-1In+1...IN type
if n==1
    Xn=reshape(X,S(1),prod(S(2:end)));
elseif n==N
    Xn=permute(reshape(X,prod(S(1:end-1)),S(N)),[2,1]);
else
    arr=[n 1:n-1 n+1:N];
    Xn=reshape(permute(X,arr),S(n),prod(S)/S(n));
end

elseif type==2 % the I1...In x In+1...IN type
    Xn=reshape(X,[prod(S(1:n)),numel(X)/prod(S(1:n))]);
    
else % the In x In+1...INI1...In-1 type
    if n==1
         Xn=reshape(X,[S(1),numel(X)/S(1)]);
    elseif n==N
         Xn=reshape(X,[numel(X)/S(N),S(N)]);
         Xn=permute(Xn,[2,1]); 
    else
        Xn=reshape(X,[prod(S(1:n-1)),numel(X)/prod(S(1:n-1))]);
        Xn=permute(Xn,[2,1]);
        Xn=reshape(Xn,[S(n),numel(X)/S(n)]);
    end
end
end