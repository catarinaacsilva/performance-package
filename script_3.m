lambda = [100, 200, 500, 1000];
C = [2, 10];
F = [100000, 10000];
P = 1000;


for l=1:size(lambda,2)
    for c = 1:size(C,2)
        for f = 1:size(F,2)
            PL = [];
            APD = [];
            MPD = [];
            TT = [];
            for i = 1:1000
                [pl, apd, mpd, tt] = Simulator1(lambda(l),C(c),F(f),P);
                PL = [PL; pl];
                APD = [APD; apd];
                MPD = [MPD; mpd];
                TT = [TT; tt];
            end
            
            meanPL = mean(PL); 
            nPL = size(PL, 1); 
            semPL = std(PL) ./ sqrt(nPL); 

            meanAPD = mean(APD); 
            nAPD = size(APD, 1); 
            semAPD = std(APD) ./ sqrt(nAPD); 

            meanMPD = mean(MPD); 
            nMPD = size(MPD, 1); 
            semMPD = std(MPD) ./ sqrt(nMPD); 

            meanTT = mean(TT); 
            nTT = size(TT, 1); 
            semTT = std(TT) ./ sqrt(nTT); 


            disp([meanPL, 1.645*semPL, meanAPD, 1.645*semAPD, meanMPD, 1.645*semMPD, meanTT, 1.645*semTT])
            
        end
    end
end