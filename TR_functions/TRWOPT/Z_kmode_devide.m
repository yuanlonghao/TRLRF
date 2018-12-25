% kl, kr are 3-order tensors.
function [kl,kr]=Z_kmode_devide(Z,k)
N=numel(Z);
if k==1
    kl=1;
    P=Z{2};
    for i=3:N
        L=reshape(P,[numel(P)/size(Z{i-1},3),size(Z{i-1},3)]);
        R=reshape(Z{i},[size(Z{i},1),numel(Z{i})/size(Z{i},1)]);
        P=L*R;
    end
    kr=reshape(P,[size(Z{2},1),numel(P)/(size(Z{2},1)*size(Z{N},3)),size(Z{N},3)]);
elseif k==N
    kr=1;
    P=Z{1};
    for i=2:N-1
        L=reshape(P,[numel(P)/size(Z{i-1},3),size(Z{i-1},3)]);
        R=reshape(Z{i},[size(Z{i},1),numel(Z{i})/size(Z{i},1)]);
        P=L*R;
    end
    kl=reshape(P,[size(Z{1},1),numel(P)/(size(Z{1},1)*size(Z{N-1},3)),size(Z{N-1},3)]);
else
    P=Z{1};
    for i=2:k-1
        L=reshape(P,[numel(P)/size(Z{i-1},3),size(Z{i-1},3)]);
        R=reshape(Z{i},[size(Z{i},1),numel(Z{i})/size(Z{i},1)]);
        P=L*R;
    end
    kl=reshape(P,[size(Z{1},1),numel(P)/(size(Z{1},1)*size(Z{k-1},3)),size(Z{k-1},3)]);
    P=Z{k+1};
    for i=k+2:N
        L=reshape(P,[numel(P)/size(Z{i-1},3),size(Z{i-1},3)]);
        R=reshape(Z{i},[size(Z{i},1),numel(Z{i})/size(Z{i},1)]);
        P=L*R;
    end
    kr=reshape(P,[size(Z{k+1},1),numel(P)/(size(Z{k+1},1)*size(Z{N},3)),size(Z{N},3)]);
end
end