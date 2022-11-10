close all; clear all; clc;

Fs = 10;
t = 0:1/Fs:2;
N1 = 10;
N2 = 20;


cos1 = cos(2*pi*4*t);
cos2 = cos(2*pi*2.5*t);
cos3 = cos(2*pi*12*t);
cos4 = cos(2*pi*7.25*t);


subplot(4,2,1); 
stem(abs(DFT(cos1,N1)),"o");
title("N = 10");
xlabel("f[Hz]"); ylabel("|A|"); 
subplot(4,2,2);
stem(abs(DFT(cos1,N2)),"o");
xlabel("f[Hz]"); ylabel("|A|"); 
title("N = 20");
xlabel("f[Hz]"); ylabel("|A|"); 
subplot(4,2,3);
stem(abs(DFT(cos2,N1)),"o");
xlabel("f[Hz]"); ylabel("|A|"); 
subplot(4,2,4);
stem(abs(DFT(cos2,N2)),"o");
xlabel("f[Hz]"); ylabel("|A|"); 
subplot(4,2,5);
stem(abs(DFT(cos3,N1)),"o");
xlabel("f[Hz]"); ylabel("|A|");
subplot(4,2,6);
stem(abs(DFT(cos3,N2)),"o");
xlabel("f[Hz]"); ylabel("|A|"); 
subplot(4,2,7);
stem(abs(DFT(cos4,N1)),"o");
xlabel("f[Hz]"); ylabel("|A|"); 
subplot(4,2,8);
stem(abs(DFT(cos4,N2)),"o");
xlabel("f[Hz]"); ylabel("|A|"); 