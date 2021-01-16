clc
clear all
close all

% Parâmetros de entrada
N = 200;
n = 0:N-1;
a = 1.1;

% Sinal no tempo
x = a.^n;
figure, stem(n,x)

% TF teórica
w = linspace(-pi,pi,N);
Xf_teo = 1./(1 - a*exp(-j*w));
figure, plot(w,abs(Xf_teo))

% TF simulada
Xf_simul = fftshift(fft(x));
hold on, plot(w,abs(Xf_simul),'r')

% TZ teórica
cc = 0;
for zr = -2:0.01:2
    cc = cc + 1;
    ll = 0;
    for zi = -2:0.01:2
        ll = ll + 1;
        z(ll,cc) = zr + zi*j;
    end
end
Xz_teo = 1./(1 - a./z);
figure, mesh(-2:0.01:2,-2:0.01:2,abs(Xz_teo))

