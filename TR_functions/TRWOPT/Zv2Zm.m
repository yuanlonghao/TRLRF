function Zm=Zv2Zm(Zv,S,r)
N=numel(S);
Zm=cell(N,1);
I=cell(N,1); % I is the number of elements of every G cores
for i=1:N-1 %  2 to N-1
    I{i}=S(i)*r(i+1)*r(i);
end
    I{N}=S(N)*r(1)*r(N);
%
index=[];
add=I{1};
for j=1:N-1
    index=[index add];
    add=add+I{j+1};
end
index=[0 index numel(Zv)];
%
for k=1:N
    Zm{k}=Zv(index(k)+1:index(k+1),1);
end
%
for d=1:N-1
Zm{d}=reshape(Zm{d},[S(d),r(d+1)*r(d)]);
end
Zm{N}=reshape(Zm{N},[S(N),r(1)*r(N)]);
end