function X=coreten2tr(Z)
N=numel(Z);
S=[];
for i=1:N
    S=[S size(Z{i},2)];
end
P=Z{1};
for i=2:N
    L=reshape(P,[numel(P)/size(Z{i-1},3),size(Z{i-1},3)]);
    R=reshape(Z{i},[size(Z{i},1),S(i)*size(Z{i},3)]);
    P=L*R;
end
P=reshape(P,[size(Z{1},1),prod(S),size(Z{N},3)]);
P=permute(P,[2,3,1]);
P=reshape(P,[prod(S),size(Z{1},1)*size(Z{1},1)]);
temp=eye(size(Z{1},1),size(Z{1},1));
P=P*temp(:);
X=reshape(P,S);
end