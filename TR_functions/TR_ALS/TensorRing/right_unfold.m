function RU = right_unfold(U)
    % input:    U is a 3rd order tensor     r_i-1 * I_i * r_i
    % output:   RU is a matrix              r_i-1 * I_i r_i
    [l, c, r] = size(U);
    RU = reshape(U, [l, c*r]);
end