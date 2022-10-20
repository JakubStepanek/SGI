clear all;
close all;
%Fs = 8000;
%Ts = 1/Fs;
%T = 2; %delka zvuku
%t = 0:Ts:T-Ts;

%f = 440;
%A = 1/5;
%sig = cos(2*pi*f*t);
%sound(sig,Fs)
%sig = [ton1, ton2, ton3]

FA4 = 440;
q = 2^(1/12);
BPM = 120;
Fs = 8000;
Ts = 1/Fs;

T_ctvrt = 1/BPM *60;
T_osmin = T_ctvrt/2;       
t_ctvrt = 0:Ts:T_ctvrt-Ts;
%t_pul = 0:Ts:T_pul-Ts;
t_osmin = 0:Ts:T_osmin-Ts;

FC4 = FA4/q^9;
FD4 = FA4/q^7;
FE4 = FA4/q^5;
FG4 = FA4/q^2;

A4_ctvrt = cos(2*pi*FA4*t_ctvrt);
%G4_pul = cos(2*pi*FG4*t_pul);
C4_osmin = cos(2*pi*FC4*t_osmin);
E4_osmin = cos(2*pi*FE4*t_osmin);
G4_ctvrt = cos(2*pi*FG4*t_ctvrt);
D4_ctvrt = cos(2*pi*FD4*t_ctvrt);
D4_osmin = cos(2*pi*FD4*t_osmin);
G4_osmin = cos(2*pi*FG4*t_osmin);
E4_ctvrt = cos(2*pi*FE4*t_ctvrt);
C4_ctvrt = cos(2*pi*FC4*t_ctvrt);

ctvrt_pauza =zeros(t_ctvrt);
%ctvrt_pauza = cos(2*pi*0*t_ctvrt);

sig = [C4_osmin, E4_osmin,  C4_osmin, E4_osmin, G4_ctvrt, G4_osmin, G4_osmin, C4_osmin, E4_osmin, C4_osmin, E4_osmin,D4_ctvrt, D4_osmin, D4_osmin, C4_osmin, E4_osmin, G4_osmin, E4_osmin, D4_osmin, D4_osmin, E4_ctvrt, C4_osmin, E4_osmin, G4_osmin, E4_osmin, D4_osmin, D4_osmin, C4_ctvrt];

sound(sig,Fs)