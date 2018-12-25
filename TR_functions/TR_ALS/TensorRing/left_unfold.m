function LU = left_unfold(U)
    % input:    U is a 3rd order tensor     r_i-1 * I_i * r_i
    % output:   LU is a matrix              r_i-1 I_i * r_i
    [l, c, r] = size(U);
    LU = reshape(U, [l*c, r]);
end