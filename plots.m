% f)
load('alinea_f.mat');
a_f = rs;
lambda = [50 100 150 200 250 270 290 310 330 350 400 450 500];

figure(1)
plot(lambda, squeeze(a_f(:,1)), 'b');
xlabel('Lambda ƛ (pps)');
ylabel('Packet Loss (%)');
title('Influence of ƛ in Packet Loss - f)');

figure(2)
plot(lambda, squeeze(a_f(:,2)), 'b', lambda, squeeze(a_f(:,3)), 'r');
legend('Average','Maximum')
xlabel('Lambda ƛ (pps)');
ylabel('Packet Delay (ms)');
title('Influence of ƛ in Average and Maximum Packet Delay - f)');

figure(3)
plot(lambda, squeeze(a_f(:,4)), 'b');
xlabel('Lambda ƛ (pps)');
ylabel('Transmitted Throughput (Mbps)');
ylim([0 2]);
title('Influence of ƛ in Transmitted Throughput - f)');

% g)
load('alinea_g.mat');
a_g = rs;
lambda = [50 100 150 200 250 270 290 310 330 350 400 450 500];

figure(4)
plot(lambda, squeeze(a_g(:,1)), 'b');
xlabel('Lambda ƛ (pps)');
ylabel('Packet Loss (%)');
title('Influence of ƛ in Packet Loss - g)');

figure(5)
plot(lambda, squeeze(a_g(:,2)), 'b', lambda, squeeze(a_g(:,3)), 'r');
legend('Average','Maximum')
xlabel('Lambda ƛ (pps)');
ylabel('Packet Delay (ms)');
title('Influence of ƛ in Average and Maximum Packet Delay - g)');

figure(6)
plot(lambda, squeeze(a_g(:,4)), 'b');
xlabel('Lambda ƛ (pps)');
ylabel('Transmitted Throughput (Mbps)');
ylim([0 2]);
title('Influence of ƛ in Transmitted Throughput - g)');

% h)
load('alinea_h.mat');
a_h = rs;
lambda = [250 500 750 1000 1250 1350 1450 1550 1650 1750 2000 2250 2500];

figure(7)
plot(lambda, squeeze(a_h(:,1)), 'b');
xlabel('Lambda ƛ (pps)');
xlim([250 2500]);
ylabel('Packet Loss (%)');
title('Influence of ƛ in Packet Loss - h)');

figure(8)
plot(lambda, squeeze(a_h(:,2)), 'b', lambda, squeeze(a_h(:,3)), 'r');
legend('Average','Maximum')
xlabel('Lambda ƛ (pps)');
xlim([250 2500]);
ylabel('Packet Delay (ms)');
title('Influence of ƛ in Average and Maximum Packet Delay - h)');

figure(9)
plot(lambda, squeeze(a_h(:,4)), 'b');
xlabel('Lambda ƛ (pps)');
xlim([250 2500]);
ylabel('Transmitted Throughput (Mbps)');
ylim([0 10]);
title('Influence of ƛ in Transmitted Throughput - h)');

% i)
load('alinea_i.mat');
a_i = rs;
lambda = [250 500 750 1000 1250 1350 1450 1550 1650 1750 2000 2250 2500];

figure(10)
plot(lambda, squeeze(a_i(:,1)), 'b');
xlabel('Lambda ƛ (pps)');
xlim([250 2500]);
ylabel('Packet Loss (%)');
title('Influence of ƛ in Packet Loss - i)');

figure(11)
plot(lambda, squeeze(a_i(:,2)), 'b', lambda, squeeze(a_i(:,3)), 'r');
legend('Average','Maximum')
xlabel('Lambda ƛ (pps)');
xlim([250 2500]);
ylabel('Packet Delay (ms)');
title('Influence of ƛ in Average and Maximum Packet Delay - i)');

figure(12)
plot(lambda, squeeze(a_i(:,4)), 'b');
xlabel('Lambda ƛ (pps)');
xlim([250 2500]);
ylabel('Transmitted Throughput (Mbps)');
ylim([0 10]);
title('Influence of ƛ in Transmitted Throughput - i)');
