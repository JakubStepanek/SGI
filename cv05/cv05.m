clear all; close all; clc;
f = 2; %Hz
Fs = 1000; %Hz
t = 0:1/Fs:1;
N = 1000; %prvků

F = 0:Fs/N:Fs/2-Fs/N;
x1 = cos(2*pi*f*t-pi/2);
x2 = cos(2*pi*f*t-pi/2);


for i = 3:2:N
    x1 = x1 + (1/i)*cos(2*pi*i*f*t-pi/2);
end

for i = 2:1:N
    x2 = x2 + (1/i)*cos(2*pi*i*f*t-pi/2);
end

X1 = fft(x1,N);
X2 = fft(x2,N);

subplot(2,2,1);
plot(t,x1);
xlabel("t[s]"); ylabel("A"); xticks([0 0.5 1]);
subplot(2,2,2);
stem(F(1:40),1/(N/2)*abs(X1(1:40)),".")
xlabel("f[Hz]"); ylabel("|A|"); yticks([0 0.5 1]);
subplot(2,2,3);
plot(t,x2);
xlabel("t[s]"); ylabel("A"); xticks([0 0.5 1]);
subplot(2,2,4);
stem(F(1:40),1/(N/2)*abs(X2(1:40)),".")
xlabel("f[Hz]"); ylabel("|A|"); yticks([0 0.5 1]);
