clear;
close all;
clc;

% načetní signálů
[sig, Fs] = audioread('DOBRYDEN.WAV');
[h, Fs2] = audioread('Reverb1.wav');

% transpozice signálů na řádkový vektor a doplnění nulami
sig = sig';
h = [h' zeros(1, length(sig) - length(h))];

y = my_conv(sig, h);

% poměr hlasitosti původního signálu a ozvěny
a = 1.0;
b = 0.5;

% doplnění nulami pro možnost součtu
sig = [sig zeros(1, length(y) - length(sig))];

% původní signál
sound(sig.*a, Fs);

pause(2);

% mix původního signálu a ozvěny
sound((sig.*a + y.*b)/(a+b), Fs);

subplot(3,1,1);
plot(sig)
title('Původní signál');
subplot(3,1,2);
plot(h)
title('Impulsní odezva');
subplot(3,1,3);
plot(y)
title('Výsledek konvoluce');


 
function y = my_conv(x,h)
vecA_size = numel(x);
vecB_size = numel(h);
finalVec = zeros(1,vecA_size+vecB_size-1);

for i = 1:numel(finalVec)
    temp = 0;
    for j = max(1,i+1-vecB_size): 1 :min(i,vecA_size)
        temp = temp + (x(j) * h(i - j + 1));
    end
    finalVec(i) = temp;
end
y = finalVec;
%y = conv(x,h);
end