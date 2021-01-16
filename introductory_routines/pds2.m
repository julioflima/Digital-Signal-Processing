close all
clc
clear all

% Carregando o sinal 
[Y,Fs]=audioread('botao.wav');
y = Y(:,1);
tempo_vec = (1:length(y))/Fs;
figure,plot(tempo_vec,y)
ylabel('Amplitude do Sinal')
xlabel('Tempo em s')
sound(y,Fs)

% Transformada de Fourier
Yw = fft(y);
freq_vec = linspace(-Fs/2,Fs/2,length(y));
figure,plot(freq_vec,fftshift(abs(Yw)))
ylabel('Espectro de magnitude')
xlabel('Frequencia em Rad/s')

% % Deslocamento na freq
y_desloc = y.*sin(0.6*pi.*(1:length(y)).');
Yw_desloc = fft(y_desloc);
figure,plot(freq_vec,fftshift(abs(Yw_desloc)))
ylabel('Espectro de magnitude do sinal deslocado')
xlabel('Frequencia em Hz')

% Gerar ruido
ruido_branco = randn(size(y));
figure,plot(tempo_vec,ruido_branco)
ylabel('Amplitude do Sinal')
xlabel('Tempo em s')
% sound(ruido_branco,Fs)
Yw_ruido_branco = fft(ruido_branco);
figure,plot(freq_vec,fftshift(abs(Yw_ruido_branco)))
ylabel('Espectro de magnitude do ruído')
xlabel('Frequencia em Hz')

% Adicionar ruido
y_ruido = y + ruido_branco*sqrt(1);
figure,plot(tempo_vec,y_ruido)
ylabel('Amplitude do Sinal com ruido')
xlabel('Tempo em s')
Yw_ruido = fft(y_ruido);
figure,plot(freq_vec,fftshift(abs(Yw_ruido)))
ylabel('Espectro de magnitude do sinal com ruido')
xlabel('Frequencia em Hz')

% Gerando filtro PB
% sound(y_ruido,Fs)
wc = 1200/(Fs/2);
[B,A] = butter(10,wc);
[H,W] = FREQZ(B,A,length(y));
figure,plot(W,abs(H))
% figure,plot(W/pi*Fs/2,unwrap(angle(H)))
h = ifft(H);
figure,stem(h(1:100),'xk')

% Filtrando o sinal
y_ruido_filtrado = filter(B,A,y_ruido);
Yw_ruido_filtrado = fft(y_ruido_filtrado);
figure,plot(freq_vec,fftshift(abs(Yw_ruido_filtrado)))
ylabel('Espectro de magnitude do sinal com ruido filtrado')
xlabel('Frequencia em Hz')
sound(y_ruido_filtrado,Fs)

