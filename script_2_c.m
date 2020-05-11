lambda1 = [100 200];            % Packet Rate
lambda2 = [500 1000];           % Packet Rate   
C = [2 10];                     % Connection Capacity 
F = [100000 10000];             % Queue
P = 100000;                       % Number of Transmitted Packets
s = 10;                       % Number of Simulations

result = [];
for c = 1:size(C, 2)
    for f = 1:size(F, 2)
        for l = 1:size(1, 2)
            aPL = [];
            aAD = [];
            aMD = [];
            aTT = [];
            if C(c) == 2
                lamda = lambda1;
            else
                lambda = lambda2;
            end 
            for i = 1:s
                [PL , APD , MPD , TT] = Simulator1(lambda(l),C(c),F(f),P);
                aPL = [aPL PL];
                aAD = [aAD APD];
                aMD = [aMD MPD];
                aTT = [aTT TT];
            end

            result(c,f,l,1) = mean(aPL) 
            result(c,f,l,2) = mean(aAD); 
            result(c,f,l,3) = mean(aMD); 
            result(c,f,l,4) = mean(aTT);
            result(c,f,l,5) = 1.645*(std(aPL)/sqrt(s))   
            result(c,f,l,6) = 1.645*(std(aAD)/sqrt(s));  
            result(c,f,l,7) = 1.645*(std(aMD)/sqrt(s));   
            result(c,f,l,8) = 1.645*(std(aTT)/sqrt(s));
        end
    end
end