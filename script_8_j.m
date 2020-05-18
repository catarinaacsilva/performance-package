L = [200 1000];             % Packet Rate - lambda data (pps)
C = [2 10];                 % Connection Capacity - C (Mbps)
F = [100000 10000];         % Queue Size - f (Bytes)
N = [5 10 15 25 50 75];     % Number of VoIP flows
P = 100000;                 % Number of Transmitted Packets
S = 10;                     % Number of Simulations

rs=[]; % result
for c = 1:size(C,2)
    for f = 1:size(F,2)
        if c == 1
            x = [1 2 3];
        else
            x = [4 5 6] ;
        end 
        for n = x(1):x(3)
            avgPLd = [];
            avgPLv = [];
            avgADd = [];
            avgADv = [];
            avgMDd = [];
            avgMDv = [];
            avgTT = [];
            for i = 1:S
                [PLd , PLv , APDd , APDv , MPDd , MPDv , TT] = Simulator2(L(c),N(n),C(c),F(f),P);
                avgPLd = [avgPLd PLd];
                avgPLv = [avgPLv PLv];
                avgADd = [avgADd APDd];
                avgADv = [avgADv APDv];
                avgMDd = [avgMDd MPDd];
                avgMDv = [avgMDv MPDv];
                avgTT = [avgTT TT];
            end
            rs(c,f,n,1) = mean(avgPLd);      % Data Packet Loss (%)
            rs(c,f,n,2) = mean(avgPLv);      % VoIP Packet Loss (%)
            rs(c,f,n,3) = mean(avgADd);      % Average Data Packet Delay (milliseconds)
            rs(c,f,n,4) = mean(avgADv);      % Average VoIP Packet Delay (milliseconds)
            rs(c,f,n,5) = mean(avgMDd);      % Maximum Data Packet Delay (milliseconds)
            rs(c,f,n,6) = mean(avgMDv);      % Maximum VoIP Packet Delay (milliseconds)
            rs(c,f,n,7) = mean(avgTT);       % Transmitted Throughput (Mbps)
            rs(c,f,n,8) = 1.645*(std(avgPLd)/sqrt(S));    % 90 Conf Inter (PLd)
            rs(c,f,n,9) = 1.645*(std(avgPLv)/sqrt(S));    % 90 Conf Inter (PLv)
            rs(c,f,n,10) = 1.645*(std(avgADd)/sqrt(S));   % 90 Conf Inter (ADd)
            rs(c,f,n,11) = 1.645*(std(avgADv)/sqrt(S));   % 90 Conf Inter (ADv)
            rs(c,f,n,12) = 1.645*(std(avgMDd)/sqrt(S));   % 90 Conf Inter (MDd)
            rs(c,f,n,13) = 1.645*(std(avgMDv)/sqrt(S));   % 90 Conf Inter (MDv)
            rs(c,f,n,14) = 1.645*(std(avgTT)/sqrt(S));    % 90 Conf Inter (TT)
        end
    end
end