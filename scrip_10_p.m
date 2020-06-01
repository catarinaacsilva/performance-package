L = [200 1000];             % Packet Rate - lambda data (pps)
C = [2 10];                 % Connection Capacity - C (Mbps)
F = 10000;                  % Queue Size - f (Bytes)
N = [5 10 15 25 50 75];     % Number of VoIP flows
P = 100000;                 % Number of Transmitted Packets
S = 10;                     % Number of Simulations
R = [25 50 75];             % Percentage

rs=[]; % result
for c = 1:size(C,2)
    if c == 1
        x = [1 2 3];
    else
        x = [4 5 6];
    end 
    for n = x(1):x(3)
        for r = 1:size(R,2)
            avgPLd = [];
            avgPLv = [];
            avgADd = [];
            avgADv = [];
            avgMDd = [];
            avgMDv = [];
            avgTT = [];
            for i = 1:S
                [PLd , PLv , APDd , APDv , MPDd , MPDv , TT] = Simulator4(L(c),N(n),C(c),F,P,R(r));
                avgPLd = [avgPLd PLd];
                avgPLv = [avgPLv PLv];
                avgADd = [avgADd APDd];
                avgADv = [avgADv APDv];
                avgMDd = [avgMDd MPDd];
                avgMDv = [avgMDv MPDv];
                avgTT = [avgTT TT];
            end
            rs(c,n,r,1) = mean(avgPLd);      % Data Packet Loss (%)
            rs(c,n,r,2) = mean(avgPLv);      % VoIP Packet Loss (%)
            rs(c,n,r,3) = mean(avgADd);      % Average Data Packet Delay (milliseconds)
            rs(c,n,r,4) = mean(avgADv);      % Average VoIP Packet Delay (milliseconds)
            rs(c,n,r,5) = mean(avgMDd);      % Maximum Data Packet Delay (milliseconds)
            rs(c,n,r,6) = mean(avgMDv);      % Maximum VoIP Packet Delay (milliseconds)
            rs(c,n,r,7) = mean(avgTT);       % Transmitted Throughput (Mbps)
            rs(c,n,r,8) = 1.645*(std(avgPLd)/sqrt(S));    % 90 Conf Inter (PLd)
            rs(c,n,r,9) = 1.645*(std(avgPLv)/sqrt(S));    % 90 Conf Inter (PLv)
            rs(c,n,r,10) = 1.645*(std(avgADd)/sqrt(S));   % 90 Conf Inter (ADd)
            rs(c,n,r,11) = 1.645*(std(avgADv)/sqrt(S));   % 90 Conf Inter (ADv)
            rs(c,n,r,12) = 1.645*(std(avgMDd)/sqrt(S));   % 90 Conf Inter (MDd)
            rs(c,n,r,13) = 1.645*(std(avgMDv)/sqrt(S));   % 90 Conf Inter (MDv)
            rs(c,n,r,14) = 1.645*(std(avgTT)/sqrt(S));    % 90 Conf Inter (TT)
        end
    end
end
