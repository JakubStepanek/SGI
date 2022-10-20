clear all; close all; clc;

BPM = 120;
FA4 = 440;
Fs = 8000;
q = nthroot(2, 12);

Ts = 1/Fs;

T_ctvrt = 1/BPM*60;
T_cela = T_ctvrt*4;
T_pul = T_ctvrt*2;
T_osmin = T_ctvrt/2;

t_ctvrt = 0:Ts:T_ctvrt-Ts;
t_pul = 0:Ts:T_pul-Ts;
t_cela = 0:Ts:T_cela-Ts;
t_osmin = 0:Ts:T_osmin-Ts;

ctvrt_pauza = zeros(size(t_ctvrt));


FC4 = FA4/q^9;
FD4 = FA4/q^7;
FE4 = FA4/q^5;
FG4 = FA4/q^2;

A4_ctvrt = cos(2*pi*FA4*t_ctvrt);
C4_osmin = cos(2*pi*FC4*t_osmin);
E4_osmin = cos(2*pi*FE4*t_osmin);
G4_ctvrt = cos(2*pi*FG4*t_ctvrt);
D4_ctvrt = cos(2*pi*FD4*t_ctvrt);
D4_osmin = cos(2*pi*FD4*t_osmin);
G4_osmin = cos(2*pi*FG4*t_osmin);
E4_ctvrt = cos(2*pi*FE4*t_ctvrt);
C4_ctvrt = cos(2*pi*FC4*t_ctvrt);


sig = [C4_osmin, E4_osmin,  C4_osmin, E4_osmin, G4_ctvrt, G4_osmin, G4_osmin, C4_osmin, E4_osmin, C4_osmin, E4_osmin,D4_ctvrt, D4_osmin, D4_osmin, C4_osmin, E4_osmin, G4_osmin, E4_osmin, D4_osmin, D4_osmin, E4_ctvrt, C4_osmin, E4_osmin, G4_osmin, E4_osmin, D4_osmin, D4_osmin, C4_ctvrt];
sound(sig, Fs)
