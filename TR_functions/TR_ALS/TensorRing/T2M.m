function M = T2M(T)
    % Input: Tensor T: k1 * 1 * k2
    % Output: Matrix M: k1 * k2
    [k1, ~ ,k2] = size(T);
    M = reshape(T, [k1, k2]);
end