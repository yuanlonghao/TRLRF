% my sigular values calculator
% calculate the sigular values of the merged two cores
% input the cell mode core tensors and the position n, calculate svd of
% merge(G{n},G{n+1})
function v=my_SVC(G,n)
N=numel(G);
n1=n;
    if n==N
        n2=1;
    else
        n2=n+1;
    end
s1=size(G{n1}); s2=size(G{n2});
Gb=reshape(G{n1},s1(1)*s1(2),[])*reshape(G{n2},s2(1),[]);
[~,v,~]=svd(Gb,'econ');
v=diag(v);
end