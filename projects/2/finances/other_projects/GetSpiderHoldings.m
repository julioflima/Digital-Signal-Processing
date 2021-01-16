function [ holdings ] = GetSpiderHoldings( sym)
%GETSPIDERHOLDINGS Summary of this function goes here
%   Detailed explanation goes here
    url = strcat('https://us.spdrs.com/site-content/xls/',sym,'_All_Holdings.xls?fund=',sym,'&docname=All+Holdings&onyx_code1=&onyx_code2=');
    filename = 'C:\Code\a2xresearch\tempfiles\sampledata.xls';
    urlwrite(url,filename,'get',{'term','urlwrite'});
    [~,~,rawData] = xlsread('C:\Code\a2xresearch\tempfiles\sampledata.xls');
    holdings = rawData(5:end,2:3);
end

