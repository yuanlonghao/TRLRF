function U = Ui2U(Ui)
    
    T = TCP(Ui);
    N = size(T,2);      % total entries of tensor
    d = length(Ui);     % tensor orders
    
    I = nan(1, d);      % diemsiona of tensor
    for i =1:d
        I(i) = size(Ui{i},2);
    end
    
    v = nan(N, 1);      % vector with entry being trace
    for i=1:N
        v(i) = trace( T2M(T(:,i,:)) );
    end
    
    U = reshape(v, I);
end