function TPi = TensPermute(T,i)
    % Input:
    % T:     I1 * I2 *...* In
    % i:            a scaler
    % Output:
    % TPi:   Ii * ... * In * I1*I2*...*I_i-1
    
    I=size(T);
    n=length(I);
    TPi=mat2tens((tens2mat(T,1:i-1, i:n))', [I(i:n),I(1:i-1)],1:n-i+1, n-i+2:n);
end