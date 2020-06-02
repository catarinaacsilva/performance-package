function [W_V,W_D] = mg1_n(c, l, n)
    p0 = 0.16;
    p1 = 0.22;
    p2 = 0.62;
    n0 = 64 * 8;
    n1 = 1518 * 8;
    
    n_D = 1517-65 + 1;
    n_V = 130-110 + 1;
    
    b = p0*n0 + p1*n1;
    es_D = p0*n0/c + p1*n1/c;
    esQ_D = p0*(n0/c)^2 + p1*(n1/c)^2;
    
    for i = 65:1517
        b = b + (p2/n_D) * (i * 8);
        es_D = es_D + (p2/n_D) * (i * 8)/c;
        esQ_D = esQ_D + (p2/n_D) * ((i * 8)/c)^2;
    end
    
    b_V = 0;
    es_V = 0;
    esQ_V = 0;
    for i = 110:130
        b_V = b_V + + (1/n_V) * (i * 8);
        es_V = es_V + (1/n_V) * (i * 8)/c;
        esQ_V = esQ_V + (1/n_V) * ((i * 8)/c)^2;
    end
    
    l_V = n/0.02;
    
    W_V = ((l * esQ_D + l_V * esQ_V) / (2 * (1 - l_V/(c/b_V))) + es_V) * 1000;
    W_D = ((l * esQ_D + l_V * esQ_V) / (2 * (1 - l_V/(c/b_V)) * (1 - l_V/(c/b_V) - l/(c/b))) + es_D) * 1000;
    
end