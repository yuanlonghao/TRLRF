function Utr = TR_ALS(U_Omega, P_Omega, para)
    % U_Omega: I1 * I2 *... *In tensor with missing entries filled by 0
    % P_Omega: I1 * I2 *... *In binary observation tensor
    % para:    para.max_iter, para.max_tot, para.r
    %
    % Utr:     Decomposition term
    
    % Initialization
    Utr = TR_Initialization(U_Omega,  para.r);
    dummy   = Utr{end};
    
    d = length(para.r);    
    tot     =1;
    iter    =0;
    
    while(tot>=para.max_tot && iter <=para.max_iter)
        lastX=coreten2tr(Utr);
        for i=1:d
            Utr{i} = Updata_U1(TensPermute(P_Omega, i), Utr([i:d, 1:i-1]),TensPermute(U_Omega, i));
        end
        % Change of the last term as error
        tot = norm(T2V(Utr{d} - dummy))/norm(T2V(dummy));
        dummy = Utr{end};
        iter =iter+1;
        X=coreten2tr(Utr);
        T=U_Omega.*P_Omega;
        err_x=abs((norm(lastX(:))-norm(X(:)))/norm(T(:)));
%    % if (err_c<5e-2 || err_x<1e-5)
 if (iter==para.disp || iter ==1)
     fprintf('TR_ALS: Iteration %.0f, err_x %.2d\n',iter,err_x);
 end
    if (err_x<para.max_tot)
        fprintf('iteration stop at %.0f\n',iter); break
    end
    end
end