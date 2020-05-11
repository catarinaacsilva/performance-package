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

for l = 1:size(lambda, 2)
    for i = 1:s
        [PL , APD , MPD , TT] = Simulator1(lambda(l),2,10000,P);
        aPL = [aPL PL];
        aAD = [aAD APD];
        aMD = [aMD MPD];
        aTT = [aTT TT];
    end
end





