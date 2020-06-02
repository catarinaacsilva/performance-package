L = [100, 200, 500, 1000];
C = [2*10^6, 10*10^6];


for l=1:size(L,2)
    W = [];
    for c = 1:size(C,2)
        w = mm1(C(c),L(l));
        W = [W;w];
    end
    disp = (W)
end

function avg = mm1(c, l)
    p0 = 0.16;
    p1 = 0.22;
    p2 = 0.62;
    n0 = 64*8;
    n1 = 1518*8;
    
    n = 1518-65;
    
    b = p0*n0 + p1*n1;
    for i = 65:1517    
        b = b + (p2/n * (i * 8));
    end

    avg = 1/((c/b)-l) * 1000;
end
