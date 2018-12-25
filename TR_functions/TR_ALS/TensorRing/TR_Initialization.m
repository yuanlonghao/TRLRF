function Ui = TR_Initialization(T,  r)
    %   T:  I_1 * I_2 * ... * I_d
    %   r:  r1, r2,..., rd
    %
    %%   Ui: r_i-1 * I_i * r_i    
    I       = size(T);
    d       = length(I);
    
    % Assign the given rank to r_tt and check feasibility
    r_tt    = zeros(d-1, 1); % r_1,..., r_d-1
    r_dummy =1;
    for i=1:d-2
        if r(i) <= r_dummy * I(i)
            r_tt(i) = r(i);
        else
            r_tt(i) = r_dummy * I(i);
        end
        r_dummy = r_tt(i);
    end
    r_tt(d-1) = min(min(r_dummy * I(d-1), I(d)), r(d-1));
    
    % TT decomposition
    Ui      = U2Ui_r(T, r_tt);
    
    % update U1
    Ut      = randn(r(d), I(1), r(1));
    Ut(1:size(Ui{1},1), 1:size(Ui{1},2), 1:size(Ui{1},3)) = Ui{1};
    Ui{1}   = Ut;
    
    % update U2 to Ud-1
    for i=2:d-1
        Ut      = randn(r(i-1), I(i), r(i));
        Ut(1:r_tt(i-1), 1:I(i), 1:r_tt(i)) = Ui{i};
        Ui{i}   = Ut;
    end
    
    % updata Ud
    Ut      = randn(r(d-1), I(d), r(d));
    Ut(1:size(Ui{d},1), 1:size(Ui{d},2), 1:size(Ui{d},3)) = Ui{d};
    Ui{d}   = Ut;
end