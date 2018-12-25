% M is the cell of size Nx3, add all the row together!
function Msum_out=Msum_fun(M)
N=size(M,1);
Msum_out=cell(N,1);
for i=1:N
    Msum_out{i}=M{i,1}+M{i,2}+M{i,3};
end

end