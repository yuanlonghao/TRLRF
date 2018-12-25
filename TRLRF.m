%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALGORITHM:
% Tensor-ring low-rank factors (TRLRF)
% Time: 12/25/2018
% Reference: "Tensor Ring Decomposition with Rank Minimization on Latent Space:
%                  An Efficient Approach for Tensor Completion", AAAI, 2019.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODEL:
% \min \limits_{[\tensor{G}],\tensor{X}}  \ &\sum_{n=1}^N\sum_{i=1}^3 \Vert \mat{G}^{(n)}_{(i)} \Vert_*
% + \frac{\lambda}{2}\Vert \tensor{X}-\Psi([\tensor{G}])\Vert_F^2\\&
% s.t.\ P_\Omega(\tensor{X})=P_\Omega(\tensor{T}).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
% data: incomplete tensor
% W: binary tensor, 1 means observed entries, 0 means missing entries
% r: TR-rank
% maxiter: 300~500
% K: hyper-parameter 0.1~1
% ro: hyper-parameter 1~1.5
% Lambda: hyper-parameter 1~10
% tol: if \Vert \tensor{X}-\tensor{X}_{last} \Vert_F / \Vert \tensor{X}\Vert_F<tol; break
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUT
% X: completed tensor
% G_out: factors of TR decomposition
% Convergence_rec: records of loss function values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [X,G_out,Convergence_rec]=TRLRF(data,W,r,maxiter,K,ro,Lamda,tol)
T=data.*W;
N=ndims(T);
S=size(T);
X=rand(S);
G=TR_initcoreten(S,r);
M=cell(N,3); 
Y=cell(N,3);
for i=1:N
    G{i}=1*G{i};
    for j=1:3
        M{i,j}=zeros(size(G{i}));
        Y{i,j}=sign(G{i});
    end
end
K_max=10^2;
Convergence_rec=zeros(1,maxiter);
iter=0;
while iter<maxiter
    iter=iter+1;
        % update G
    for n=1:N
        Msum=Msum_fun(M);
        Ysum=Msum_fun(Y);
        Q=tenmat_sb(Z_neq(G,n),2);  Q=Q'; % Q is the right part of the right part of the relation equation
        G{n}=Gfold((Lamda*tenmat_sb(X,n)*Q'...
            +K*Gunfold(Msum{n},2)+Gunfold(Ysum{n},2))*pinv((Lamda*(Q*Q')...
            +3*K*eye(size(Q,1),size(Q,1)))),size(G{n}),2);
        % update M
        for j=1:3
           Df=Gunfold(G{n}-Y{n,j}/K,j);
           M{n,j}=Gfold(Pro2TraceNorm(Df,1/K),size(G{n}),j);
        end
        
    end
    % update X
    lastX=X;
    X_hat=coreten2tr(G);
    X=X_hat;
    X(W==1)=T(W==1);
    
    % update Y
    for n=1:N
        for j=1:3
        Y{n,j}=Y{n,j}+K*(M{n,j}-G{n});
        end
    end
    K=min(K*ro,K_max);
    
    % evaluation
    G_out=G;
    err_x=abs((norm(lastX(:))-norm(X(:)))/norm(X(:)));
    if (err_x<tol)
        fprintf('iteration stop at %.0f\n',iter); break
    end
    if (mod(iter,100)==0||iter==1)
        Ssum_G=0; % singular value
        for j=1:N
            [~,vz1,~]=svd(double(mytenmat(G{j},1,1)),0);
            [~,vz2,~]=svd(double(mytenmat(G{j},2,1)),0);
            [~,vz3,~]=svd(double(mytenmat(G{j},3,1)),0);
            Ssum_G=Ssum_G+sum(vz1(:))+sum(vz2(:))+sum(vz3(:));
        end
        f_left=Ssum_G;
        f_right=Lamda*(norm(X(:)-X_hat(:)))^2;
        Convergence_rec(iter)=f_left+f_right;
        fprintf('TRLRF: Iter %.0f, Diff %.2d, Reg %.2d, Fitting %.2d\n',iter,err_x,f_left,f_right);
    end
end
end