% Average values of the performance parameters - m/m/1/m
% ------------------------------------------------------------------------------------------------------------

C = 10;
F = 10000;
lambda = [250 500 750 1000 1250 1350 1450 1550 1650 1750 2000 2250 2500];
P = 100000;

s = 10; % Number of Simulations

% aPL: Packet Loss results (PL); 
% aAPD: Average Packet Delay results (APD);
% aMPD: Maximum Packet Delay results (MPD);
% aTT: Transmitted Throughput results (TT)

rs=[];
for l = 1:size(lambda, 2)
    aPL = [];
    aAD = [];
    aMD = [];
    aTT = [];
    for i = 1:s
        [PL , APD , MPD , TT] = Simulator1(lambda(l),C,F,P);
        aPL = [aPL PL];
        aAD = [aAD APD];
        aMD = [aMD MPD];
        aTT = [aTT TT];
    end
    rs(l,1) = mean(aPL);        % Packet Loss (%)
    rs(l,2) = mean(aAD);        % Average Packet Delay (milliseconds)
    rs(l,3) = mean(aMD);        % Maximum Packet Delay (milliseconds)
    rs(l,4) = mean(aTT);        % Transmitted Throughput (Mbps)
end





