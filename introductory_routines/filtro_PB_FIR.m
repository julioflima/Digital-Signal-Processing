clc
clear all
close all

% Parametros
M = 50;
wc = 0.5*pi;
n = 0:M;
nd = M/2;

% RI do filtro PB
h = sin(wc*(n-nd))./(pi*(n-nd));
h(M/2+1) = wc/pi;
stem(h)

% RF do filtro PB
H = fftshift(fft(h,M));
figure,plot(linspace(-pi,pi,length(H)),abs(H))

