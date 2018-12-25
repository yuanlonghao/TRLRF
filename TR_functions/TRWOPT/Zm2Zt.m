function Zt=Zm2Zt(Zm,r)
N=numel(Zm);
Zt=cell(N,1);
for i=1:N-1
    Zt{i}=reshape(Zm{i},[size(Zm{i},1),r(i),r(i+1)]);
    Zt{i}=permute(Zt{i},[2,1,3]);
end
 Zt{N}=reshape(Zm{N},[size(Zm{N},1),r(N),r(1)]);
 Zt{N}=permute(Zt{N},[2,1,3]);
end