function [X] = tUnfold( X, i )
S=size(X);
X=reshape(X,[prod(S(1:i)),numel(X)/prod(S(1:i))]);
end