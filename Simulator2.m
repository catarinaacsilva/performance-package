function [PLd ,PLv, APDd , APDv, MPDd, MPDv, TT] = Simulator2(lambda,n,C,f,P)
% INPUT PARAMETERS:
%  lambda - packet rate (packets/sec)
%  n      - number of VoIP flows
%  C      - link bandwidth (Mbps)
%  f      - queue size (Bytes)
%  P      - number of packets (stopping criterium)
% OUTPUT PARAMETERS:
%  PLd    - packet loss of data packets (%)
%  PLv    - packet loss of VoIP packets (%)
%  APDd   - average packet delay of data packets (milliseconds)
%  APDv   - average packet delay of VoIP packets (milliseconds)
%  MPDd   - maximum packet delay of data packets (milliseconds)
%  MPDv   - maximum packet delay of VoIP packets (milliseconds)
%  TT     - transmitted throughput (data + VoIP) (Mbps)

%Events:
ARRIVAL= 0;       % Arrival of a packet            
DEPARTURE= 1;     % Departure of a packet

DATA = 0;         % Data packet
VOIP = 1;         % VoIP packet

%State variables:
State = 0;          % 0 - connection free; 1 - connection bysy
QueueOccupation= 0; % Occupation of the queue (in Bytes)
Queue= [];          % Size and arriving time instant of each packet in the queue

%Statistical Counters:
TotalPacketsD= 0;       % No. of data packets arrived to the system
TotalPacketsV= 0;       % No. of VoIP packets arrived to the system
LostPacketsD= 0;        % No. of data packets dropped due to buffer overflow
LostPacketsV= 0;        % No. of VoIP packets dropped due to buffer overflow
TransmittedPacketsD= 0; % No. of transmitted data packets
TransmittedPacketsV= 0; % No. of transmitted VoIP packets
TransmittedBytes= 0;    % Sum of the Bytes of transmitted packets
DelaysD= 0;             % Sum of the delays of transmitted data packets
DelaysV= 0;             % Sum of the delays of transmitted VoIP packets
MaxDelayD= 0;           % Maximum delay among all transmitted data packets
MaxDelayV= 0;           % Maximum delay among all transmitted VoIP packets

%Auxiliary variables:
% Initializing the simulation clock:
Clock= 0;

% Initializing the List of Events with the first ARRIVAL:
EventList = [ARRIVAL , Clock + exprnd(1/lambda) , GeneratePacketSizeData() , 0, DATA];
for i=1:n
    EventList= [EventList; ARRIVAL , Clock + 0.02*rand() , GeneratePacketSizeVoIP() , 0, VOIP];
end

%Similation loop:
while TransmittedPacketsD+TransmittedPacketsV<P     % Stopping criterium
    EventList= sortrows(EventList,2);               % Order EventList by time
    Event= EventList(1,1);                          % Get first event and 
    Clock= EventList(1,2);                          %   and
    PacketSize= EventList(1,3);                     %   associated
    ArrivalInstant= EventList(1,4);                 %   parameters.
    PacketType= EventList(1,5);                     %
    EventList(1,:)= [];                             % Eliminate first event
    switch Event
        case ARRIVAL                                % If first event is an ARRIVAL     
            if PacketType == DATA
                TotalPacketsD= TotalPacketsD+1;
                EventList = [EventList; ARRIVAL , Clock + exprnd(1/lambda) , GeneratePacketSizeData() , 0, PacketType];
                if State==0
                    State= 1;
                    EventList = [EventList; DEPARTURE , Clock + 8*PacketSize/(C*10^6) , PacketSize , Clock, PacketType];
                else
                    if QueueOccupation + PacketSize <= f
                        Queue= [Queue;PacketSize , Clock, PacketType];
                        QueueOccupation= QueueOccupation + PacketSize;
                    else
                        LostPacketsD= LostPacketsD + 1;
                    end
                end
            else        % VoIP packet
                TotalPacketsV= TotalPacketsV+1;
                EventList = [EventList; ARRIVAL , Clock +  0.016+0.008*rand(), GeneratePacketSizeVoIP() , 0, PacketType];
                if State==0
                    State= 1;
                    EventList = [EventList; DEPARTURE , Clock + 8*PacketSize/(C*10^6) , PacketSize , Clock, PacketType];
                else
                    if QueueOccupation + PacketSize <= f
                        Queue= [Queue;PacketSize , Clock, PacketType];
                        QueueOccupation= QueueOccupation + PacketSize;
                    else
                        LostPacketsV= LostPacketsV + 1;
                    end
                end
            end
        case DEPARTURE              % If first event is a DEPARTURE
            TransmittedBytes= TransmittedBytes + PacketSize;
            if PacketType == DATA
                DelaysD= DelaysD + (Clock - ArrivalInstant);
                if Clock - ArrivalInstant > MaxDelayD
                    MaxDelayD= Clock - ArrivalInstant;
                end
                TransmittedPacketsD= TransmittedPacketsD + 1;
            else        % VoIP packet
                DelaysV= DelaysV + (Clock - ArrivalInstant);
                if Clock - ArrivalInstant > MaxDelayV
                    MaxDelayV= Clock - ArrivalInstant;
                end
                TransmittedPacketsV= TransmittedPacketsV + 1;
            end
            if QueueOccupation > 0
                EventList = [EventList; DEPARTURE , Clock + 8*Queue(1,1)/(C*10^6) , Queue(1,1) , Queue(1,2), Queue(1,3)];
                QueueOccupation= QueueOccupation - Queue(1,1);
                Queue(1,:)= [];
            else
                State= 0;
            end
    end
end

%Performance parameters determination:
PLd= 100*LostPacketsD/TotalPacketsD;      % in %
PLv= 100*LostPacketsV/TotalPacketsV;      % in %
APDd= 1000*DelaysD/TransmittedPacketsD;   % in milliseconds
APDv= 1000*DelaysV/TransmittedPacketsV;   % in milliseconds
MPDd= 1000*MaxDelayD;                     % in milliseconds
MPDv= 1000*MaxDelayV;                     % in milliseconds
TT= 10^(-6)*TransmittedBytes*8/Clock;     % in Mbps

end

function out= GeneratePacketSizeData()
    aux= rand();
    if aux <= 0.16
        out= 64;
    elseif aux >= 0.78
        out= 1518;
    else
        out = randi([65 1517]);
    end
end

function out= GeneratePacketSizeVoIP()
    out = randi([110 130]);
end
