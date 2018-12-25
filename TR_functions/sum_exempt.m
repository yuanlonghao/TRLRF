function Msum=sum_exempt(M,i)
N=numel(M);
Msum=zeros(size(M{1}));
for k=1:N
    if k==i
        Msum=Msum+0;
    else
    Msum=Msum+M{k};
    end
end
end
