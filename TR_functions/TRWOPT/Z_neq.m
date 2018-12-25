function Z_neq_out=Z_neq(Z,n)
Z=circshift(Z,-n); % arrange Z{n} to the last core, so we only need to multiply the first N-1 core
N=size(Z,1);
P=Z{1};
for i=1:N-2
    zl=reshape(P,numel(P)/size(Z{i},3),size(Z{i},3));
    zr=reshape(Z{i+1},size(Z{i+1},1),numel(Z{i+1})/size(Z{i+1},1));
    P=zl*zr;
end
Z_neq_out=reshape(P,size(Z{1},1),numel(P)/(size(Z{1},1)*size(Z{N-1},3)),size(Z{N-1},3));
end