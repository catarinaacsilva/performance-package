L = [100, 200, 500, 1000];
C = [2, 10];


for l=1:size(L,2)
    W = [];
    for c = 1:size(C,2)
        [w] = mm1(c,l)
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
    n2_aux = (1517+65)/2;
    n2 = n2_aux*8;

    b = p0*n0 + p1*n1 + p2*n2;

    avg = 1/((c/b)-l);
end
