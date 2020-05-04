lambda1 = [100 200];            % Packet Rate
lambda2 = [500 1000];           % Packet Rate   
C = [2 10];                     % Connection Capacity 
F = [100000 10000];             % Queue
P = 100000;                       % Number of Transmitted Packets
s = 10;                       % Number of Simulations

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

            packet_loss = mean(aPL) 
            av_packet_delay = mean(aAD); 
            max_packet_delay = mean(aMD); 
            trans = mean(aTT);
            packet_loss_conf = 1.645*(std(aPL)/sqrt(s))   
            av_packet_delay_conf = 1.645*(std(aAD)/sqrt(s));  
            max_packet_delay_conf = 1.645*(std(aMD)/sqrt(s));   
            trans_conf = 1.645*(std(aTT)/sqrt(s));
        end
    end
end