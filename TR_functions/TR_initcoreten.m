% this is for simulation data, randomly generate tensor cores Z 
function Z=TR_initcoreten(S,r)
N=numel(S);
Z=cell(N,1);
for i=1:N-1
    Z{i}=randn(r(i),S(i),r(i+1));
end
    Z{N}=randn(r(N),S(N),r(1));
    % below is from Qibin
%   for i=1:N
%             Z{i} = Z{i}./max(abs(Z{i}(:)));
%   end
end