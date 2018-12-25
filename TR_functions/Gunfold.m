
% only for unfold core tensors to 3 different mode
function Gm=Gunfold(Gt,n)
if n==1
    Gm=reshape(Gt,size(Gt,1),size(Gt,2)*size(Gt,3));
elseif n==2
    Gm=reshape(permute(Gt,[2,1,3]),size(Gt,2),size(Gt,1)*size(Gt,3));
elseif n==3
    Gm=reshape(permute(Gt,[3,1,2]),size(Gt,3),size(Gt,1)*size(Gt,2));
else
    fprintf('wrong!');
end

end