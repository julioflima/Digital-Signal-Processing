clear all
clc
close all

% % EXEMPLO 1
% 
% % Resposta ao impulso igual à função exponencial (truncada)
% M = 50;
% h = 0.5.^(0:M);
% figure,stem(h,'.')
% 
% % Sinal de entrada 
% n = 0:100;
% x = cos(pi/8*n);
% % x = ones(600,1);
% figure,plot(x)
% 
% % Sinal de saída usando a convoluçao
% y = conv(h,x);
% figure,plot(y)
% 
% % Sinal de saída usando a equaçao de diferenças (função degrau unitário)
% B = 1;
% A = [1 -1/2];
% y2 = filter(B,A,x);
% hold on,plot(y2,'r')

% EXEMPLO 2

% Resposta ao impulso igual à função degrau unitário (truncada)
M = 50;
h = zeros(M,1);
h(M/2+1:end,1) = ones(M/2,1);
figure,plot(h)

% Sinal de entrada 
x = ones(1000,1);
figure,plot(x)

% Sinal de saída usando a convoluçao
y = conv(h,x);
figure,plot(y)

% Sinal de saída usando a equaçao de diferenças (função degrau unitário)
B = 1;
A = [1 -1];
y2 = filter(B,A,x);
hold on,plot(y2,'r')