clear all; close all; clc;

data = audioread("ovcaci-housle.wav");
metadata = audioinfo("ovcaci-housle.wav");

sampleCount = 256;
overleap = 128;
overleapCoefficient = sampleCount / overleap;

zcr = getZeroCrossingRate(data, sampleCount, overleap);

figure;
tiledlayout(3,1);
nexttile;
dataTime = (0:metadata.TotalSamples-1)/metadata.SampleRate;
plot(dataTime,data);

nexttile;
time = (0:overleap:metadata.TotalSamples - 1);
time = time(1:end - 1);
time = time / metadata.SampleRate;

plot(time, zcr);

nexttile;
spectrogram(data, hamming(sampleCount), overleap, sampleCount, metadata.SampleRate, 'yaxis');
    
