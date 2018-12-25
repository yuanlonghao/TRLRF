% generate tensor W by size and missing rate
function W=gen_W(S,mr)

Omega = randperm(prod(S)); 
Omega = Omega(1:round((1-mr)*prod(S)));
W = zeros(S); 
W(Omega) = 1;

end