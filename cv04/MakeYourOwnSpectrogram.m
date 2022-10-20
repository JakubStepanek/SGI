% program vypočítá a zobrazí spektrogram signálu
% 1) přímo voláním funkce spectrogram
% 2) jednoduchým výpočtem z návratových hodnot funkce spectrogram
clear all;close all; clc;
[x,Fs] = audioread('DOBRYDEN.wav');
segment_length  = 320; % délka segmentů, 160 vzorků odpovídá 10 ms
segment_overlap = 0; % překryv segmentů
nfft  = 32; % počet kanálů ve spektru, vhodné jsou mocniny 2
subplot(1,2,1);
spectrogram(x,segment_length,segment_overlap,nfft,Fs,'yaxis');
title ('spektrogram vytvořený voláním funkce')
subplot(1,2, 2);
[s,f,t,ps] = spectrogram(x,segment_length,segment_overlap,nfft,Fs,'yaxis'); % spočítáme hodnoty spektrogramu
as = abs (s); % určíme modul komplex. hodnot spektrogramu  
grayImage = uint8(255 * mat2gray(as,[0 1])) % převedeme matici as na čísla mezi 0 a 255 
grayImageFlipped = flip (grayImage); % otočíme matici, aby vyšší frekvence byly nahoře jak je zvykem u spektrogramu  
image (grayImageFlipped); % zobrazíme matici
title ('vlastní spektrogram vypočtený a vykreslený')
colormap(gray); % pro obrázky použijeme šedou stupnici




