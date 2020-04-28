L = [100, 200, 500, 1000];



%função com c e l
%estimar o b
%devolve

C = [2*10^6, 10*10^6];


for l=1:size(L,2)
    W = [];
    for c = 1:size(C,2)
        [w] = 1/(c/b);
        W = [W;w];
    end
    disp = (W)
end


