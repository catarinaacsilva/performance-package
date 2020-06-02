L = [100, 200, 500, 1000];
C = [2*10^6, 10*10^6];

for l=1:size(L,2)
    W = [];
    for c = 1:size(C,2)
        w = mg1(C(c),L(l));
        W = [W;w];
    end
    disp = (W)
end

function avg = mg1(c, l)
    p0 = 0.16;
    p1 = 0.22;
    p2 = 0.62;
    n0 = 64*8;
    n1 = 1518*8;
    n = 1518-65;
    
    es = p0*n0/c + p1*n1/c;
    esQ = p0*(n0/c)^2 + p1*(n1/c)^2;
    
    for i = 65:1517
        es = es + (p2/n)*i*8/c;
        esQ = esQ + (p2/n)*((i*8)/c)^2;
    end

    avg = ((l*esQ)/(2*(1-l*es))+es) * 1000;
end





