function Ui = U2Ui_r(U, r)
    % Input: 
    % U: I1 * I2 ... * In       (tensor)
    % r: r1 , r2 ... , rn-1     (tensor train rank)
    %
    % Output:
    % Ui:{U1,..., Un}           each Uj is a 3-mode tensor
    
    n   = size(U);
    dim = size(n,2);
    Ui = cell(dim, 1);
    
    % Initialize B
    B =[];
    for i = 1:1:n(1)
        B = [B T2V(U(i,:,:,:))];
    end
    B = B';
    
    % svd for the initialized B
    [u, s, v] = svd(B,'econ');
      
    % Process svd result
    u = u(:, 1:r(1));
    s = s(1: r(1), 1:r(1));
    v = v(:, 1:r(1));
    v = s * v';
    
    % store output result
    Ui{1} = reshape(u, [1, size(u)]);
    
    % main loop
    for i =2 : 1 : dim-1
        B = reshape(v, [r(i-1)*n(i), prod(n(i+1:end))]);
        [u,s,v] = svd(B, 'econ');
        u = u(:, 1:r(i));
        Ui{i} = reshape(u, [r(i-1), n(i), r(i)]);
        s = s(1: r(i), 1:r(i));
        v = v(:, 1:r(i));
        v = s * v';
    end
    Ui{i+1} = v;
end