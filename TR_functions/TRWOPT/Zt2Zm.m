% matrix form is In x rn-1rn
function Zm=Zt2Zm(Z)
N=numel(Z);
Zm=cell(N,1);
for i=1:N
    Zm{i}=double(tenmat(Z{i},2));
end
end