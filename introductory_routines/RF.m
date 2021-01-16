clear all
close all
clc

w1 = pi/4;
w2 = pi/3;
N = 1000;

% Exponencial complexa
n = 1:N;
xn = cos(w1*n);% + cos(w2*n);

% SLIT 
h = [0 0 0 0 0 1 0 0 0 0];
yn = conv(h,xn);
figure,plot(n,xn)
hold on,plot(1:length(yn),yn,'r')


figure,plot(linspace(-pi,pi,length(xn)),abs(fftshift(fft(xn))),'-')
hold on,plot(linspace(-pi,pi,length(yn)),abs(fftshift(fft(yn))),'-r')

