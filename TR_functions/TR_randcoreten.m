% this is for simulation data, randomly generate tensor cores Z 
function Z=TR_randcoreten(S,r)
N=numel(S);
Z=cell(N,1);
for i=1:N-1
    Z{i}=0.5*rand(r(i),S(i),r(i+1));
  %  Z{i}=Z{i}/norm(Z{i}(:));
%   Z{i}=unifrnd(-0.5,0.5,r(i),S(i),r(i+1));
end
     Z{N}=0.5*rand(r(N),S(N),r(1));
 %  Z{N}=Z{N}/norm(Z{N}(:));
%    Z{N}=unifrnd(-0.5,0.5,r(N),S(N),r(1));
end