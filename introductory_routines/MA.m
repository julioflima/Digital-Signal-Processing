clc
clear all
% close all

x = (1:100) + 5*randn(1,100);
figure,plot(x)
M = 15;
for n = M+1:100
    y(n) = mean(x(n-M:n));
end
hold on,plot(y,'r')