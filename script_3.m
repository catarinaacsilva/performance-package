lambda = [100, 200, 500, 1000]
C = [2, 10]
F = [100000, 10000]
P = 1000


for l=1:size(w,2)
    for c = 1:size(C,2)
        for F = 1:size(F,2)
            result = [];
            for i = 1:1000
                result = Simulator1(lambda(l),C(c),F(f),P)
            end
        end
    end
end