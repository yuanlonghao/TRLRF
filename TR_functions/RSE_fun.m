function RSE_list=RSE_fun(X,X_hat,W)

% global RSE 
err=X_hat(:)-X(:);
RSE_list(1)=sqrt(sum(err.^2)/sum(X(:).^2));

% RSE of observed entries
X_hat_w=X_hat.*W;
X_w=X.*W;
err_w=X_hat_w(:)-X_w(:);
RSE_list(2)=sqrt(sum(err_w.^2)/sum(X_w(:).^2));

% RSE of missing entries
Wr=~W;
X_hat_wr=X_hat.*Wr;
X_wr=X.*Wr;
err_wr=X_hat_wr(:)-X_wr(:);
RSE_list(3)=sqrt(sum(err_wr.^2)/sum(X_wr(:).^2));

end