clear all; clc; close all;


Fs = 20;
T = 2;
Ts = 1/Fs;
t = 0:Ts:T-Ts;

f1 = 4;
f2 = 2;

A1 = 2;
A2 = 4;

fi1 = pi/3;
fi2 = pi/4;
M = 0;

x1 = A1 * cos(2 * pi * f1 * t + fi1) + M;
x2 = A2 * cos(2 * pi * f2 * t + fi2) + M;
xSoucet = x1+x2;

subplot(3,2,1); %[1 3] pro sloupec
plot(t, x1);
title("x1");
subplot(3,2,2);
stem(t, x1);
title("x1");
subplot(3,2,3);
plot(x2);
title("x2")
subplot(3,2,4);
stem(x2);
title("x2");
subplot(3,1,3);
plot(xSoucet)
title("Soucet");
xlabel("t [s]")
ylabel("x(t)")