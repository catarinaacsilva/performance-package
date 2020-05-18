% Average values of the performance parameters - m/m/1/m
% ------------------------------------------------------------------------------------------------------------

C = 2;
F = 10000;
lambda = [50 100 150 200 250 270 290 310 330 350 400 450 500];
P = 100000;

s = 10; % Number of Simulations


% aPL: Packet Loss results (PL); 
% aAPD: Average Packet Delay results (APD);
% aMPD: Maximum Packet Delay results (MPD);
% aTT: Transmitted Throughput results (TT)

for l = 1:size(lambda, 2)
    for i = 1:s
        [PL , APD , MPD , TT] = Simulator1(lambda(l),C,F,P);
        aPL = [aPL PL];
        aAD = [aAD APD];
        aMD = [aMD MPD];
        aTT = [aTT TT];
    end
end




