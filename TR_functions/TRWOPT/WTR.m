function X_hat=WTR(X,W,r,maxiter)

Z0_v=TR_initcoreten(size(X),r);
Z0_v=0.08*Zm2Zv(Zt2Zm(Z0_v));
fprintf('------TR Weighted Optimization ---------- \n\n');
 options = lbfgs('defaults');
 options.MaxIters =maxiter;
 options.StopTol = 1e-100;
 options.RelFuncTol = 1.0e-100;
 options.DisplayIters = 50;
 options.MaxFuncEvals=1.0e+100;
 out=lbfgs(@(Zv) tr_wfg(X,W,Zv,r),Z0_v, options);
 Z_opted=Zm2Zt(Zv2Zm(out.X,size(X),r),r);
 X_hat=coreten2tr(Z_opted);
end