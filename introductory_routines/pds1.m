clear all
% close all
clc


% [y,Fs,nbits]= wavread('botao.wav');
% y = y(:,1);

% Carregando o sinal 
load train  
% load chirp
% y = y(1:2:end);
% Fs = Fs/4;
figure,plot(y)
tempo_vec = (1:length(y));
ylabel('Amplitude do Sinal')
xlabel('Tempo discreto')
% figure,plot(tempo_vec,y)
% ylabel('Amplitude do Sinal')
% xlabel('Tempo em s')
sound(y,Fs)


% % Transformada de Fourier
% M = 256;
Yw = fftshift(fft(y));
% freq_vec = linspace(0,2*pi,M);
% figure,plot(freq_vec,abs(Yw))
% ylabel('Espectro de magnitude')
% xlabel('Frquencia em rad/s')

freq_vec = linspace(-pi/2,pi/2,length(y));
figure,plot(freq_vec,abs(Yw))
ylabel('Espectro de magnitude')
xlabel('Frquencia em Rad/s')

