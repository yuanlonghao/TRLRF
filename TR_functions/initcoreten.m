function G=initcoreten(S,r)
% receive the original tensor and return cell G contains tt core tensors
% Nx1 cell  every cell is a 2-mode matrix
N=numel(S);
G=cell(N,1);
for i=2:N-1
    G{i}=randn(r(i-1),S(i),r(i));
end
G{1}=randn(1,S(1),r(1));
G{N}=randn(r(N-1),S(N),1);


for i=1:N
    G{i}=G{i}./max(abs(G{i}(:)));
end

%fprintf('The sizes of initial guess core tensors in cell mode is ');
%G
