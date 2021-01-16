clear all
close all
clc

% Lendo o sinal .wave
[yn,Fs,nbits] = audioread('botao.wav');  % chirp.wav
yn = yn(:,1);

% Sinal no tempo
tempo = (1:length(yn)).';
figure,plot(tempo,yn)
% sound(yn,Fs)

% Calculando TF
Yf = fftshift(fft(yn));
freq = linspace(-pi,pi,length(Yf));
% freq = linspace(-Fs/2,Fs/2,length(Yf));
figure,plot(freq,abs(Yf))
grid on
% figure,plot(freq,10*log10(abs(Yf).^2))

% Sinal deslocado no tempo
yd = [zeros(10000,1); yn];
figure,plot(yd)

% Calculando TF
Ydf = fftshift(fft(yd));
freqd = linspace(-pi,pi,length(Ydf));
figure,plot(freqd,abs(Ydf))
grid on

% Sinal deslocado na frequência
yd2 = yn.*cos(0.4*pi*tempo);
figure,plot(yd2)

% Calculando TF
Yd2f = fftshift(fft(yd2));
figure,plot(freq,abs(Yd2f))
grid on
