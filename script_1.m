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
            for i = 1:10
                [pl, apd, mpd, tt] = Simulator1(lambda(l),C(c),F(f),P);
                PL = [PL; pl];
                APD = [APD; apd];
                MPD = [MPD; mpd];
                TT = [TT; tt];
            end
            SEM = std(PL)/sqrt(length(PL));               % Standard Error
            ts = tinv([0.025  0.975],length(PL)-1);      % T-Score
            CIpl = mean(PL) + ts*SEM; % Confidence Intervals
            
            SEM = std(APD)/sqrt(length(APD));               % Standard Error
            ts = tinv([0.025  0.975],length(APD)-1);      % T-Score
            CIapd = mean(APD) + ts*SEM; % Confidence Intervals
            
            SEM = std(MPD)/sqrt(length(MPD));               % Standard Error
            ts = tinv([0.025  0.975],length(MPD)-1);      % T-Score
            CImpd = mean(MPD) + ts*SEM; % Confidence Intervals
            
            SEM = std(TT)/sqrt(length(TT));               % Standard Error
            ts = tinv([0.025  0.975],length(TT)-1);      % T-Score
            CItt = mean(TT) + ts*SEM; % Confidence Intervals
            
            disp([lambda(l), C(c), F(f), CIpl, CIapd, CImpd, CItt])
        end
    end
end