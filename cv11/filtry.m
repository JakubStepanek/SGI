close all;
clear all;

A = 1;
%B = fir1(41, 0.3, 'high');
%B = fir2(81, [0 0.47 0.53 1], [0 0 0.4 1]);

% [n,Wn] = buttord(0.5,0.55,3,120);
% [B,A] = butter(n,Wn);

% [n,Wn] = buttord([0.250 0.80],[0.3 0.5],3,60);
% [B,A] = butter(n,Wn, 'stop');

[n,Wp] = cheb1ord([0.250 0.80],[0.3 0.5],3,60)
[B,A] = cheby1(n,3,Wp, 'stop');

zplane(B,A);
figure;
freqz(B,A);

% X = fft(Num, 1000);
% plot(0:1/1000:0.5-1/1000, abs(X(1:500)));
% ylabel('|A|')
% xlabel('F')


% 
% t=0:1/8000:2-1/8000;
% x = 3*sin(2*pi*1*t)-2;
% plot(t,x);
% ylabel('x(t)')
% xlabel('t [s]')
