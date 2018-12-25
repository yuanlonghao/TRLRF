% Zm is cell mode classical mode-2 unfolding of gradient of tensor cores
function Z_v=Zm2Zv(Zm)
Z_v=[];
N=numel(Zm);
for i=1:N
    x=Zm{i}(:);
    Z_v=[Z_v;x];
end
end