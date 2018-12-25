% fold core tensor to original size
function Gt_out=Gfold(Gm,SGt,n)
if n==1
    Gt_out=reshape(Gm,[SGt(1),SGt(2),SGt(3)]);
elseif n==2
    Gt_out=permute(reshape(Gm,SGt(2),SGt(1),SGt(3)),[2,1,3]);
elseif n==3
    Gt_out=permute(reshape(Gm,SGt(3),SGt(1),SGt(2)),[2,3,1]);
else
    fprintf('wrong!');
end

end