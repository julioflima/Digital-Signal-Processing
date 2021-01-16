%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%       Universidade Federal do Ceará                               %
%       Class: Processamento Digital de Sinais                      %
%       Student: Julio Cesar Ferreira Lima                          %
%       Professor: CARLOS ALEXANDRE ROLIM FERNANDES                 %
%       Enrrollment: 393849                                         %
%       Homework: FFT Prediction                                    %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fft_prediction()

close all
clc

    %M1 Money Stock - EUA
    m1USA = getStock('M1');
    
    %M1 Money Multiplier
    m1MultiUSA = getStock('MULT');
    
    %S&P 500
    sp500 = getStock('SP500');
    
    %Effective Federal Funds Rate
    fedfunds = getStock('FEDFUNDS');

    %Real Personal Consumption Expenditures
    pcec = getStock('PCEC96');
       
    %Selic Annualyzed Percetual Monthly: 4189
    sgs4189 = getStock('SGS4189');
    
    %Selic Annualyzed Percetual Daily: 1178
    sgs1178 = getStock('SGS1178');
    
    %Selic Percetual Monthly: 4390
    sgs4390 = getStock('SGS4390');
    
    %Selic Percetual Daily: 11
    selic = getStock('SGS11');
    
    %SPY
    spy = getStock('SPY');
    
    %Banco do Brasil
    bb = getStock('BBAS3');
    
    %Petrobras
    petro = getStock('PETR4');
    
    %Ibovespa
    ibov = getStock('IBOV');
    
    %Itau
    itau = getStock('ITUB4');
    
    data = fedfunds;
    
    % Regression!
    %Defining variables, out of scope to test.
    order = 5;
    lambda = .1;
    
    %Determining x and y.
    abscissa = data.time;
    ordinate1 = data.price;
    
    %Determining samples.
    samp = size(abscissa,1);
    
    sampInterpol = 100;
    
    %Redefining
    data.priceHigh = data.price;
    ordinate = data.price(1:end-sampInterpol);
    abscissa1 = (1:(samp))';
    abscissa = (1:(samp-sampInterpol))';
    samp1 = samp;
    samp = samp - sampInterpol;
    
    %Plot Stock Curve.
    plot((1:samp), ordinate);
    
    hold on;
    
    switch order ~=0
        case order == 2
            X = [ones(samp,1) abscissa abscissa.^2];
        case order == 3
            X = [ones(samp,1) abscissa abscissa.^2 abscissa.^3];
        case order == 4
            X = [ones(samp,1) abscissa abscissa.^2 abscissa.^3 abscissa.^4];
        case order == 5
            X = [ones(samp,1) abscissa abscissa.^2 abscissa.^3 abscissa.^4 abscissa.^5];
    end
    
    %Applying the Tikhonov regularization.
    xMDim = order + 1;

    %Applying the Multiple Regression Method to obtain Beta.
    beta = (inv((X'*X + lambda*xMDim)))*(X'*ordinate);
    
    %Generate the Regression Curve.
    regCurve = X*beta;
    
    %Plot Regression Curve.
    plot((1:samp), regCurve, 'g');
    title('Least Squares and Stock Price')
    hold off
    
    %Determining the Power Medium.
    medPower = mean(ordinate);
    
    %Determining the difference.
    diff = minus(ordinate, regCurve);

    %Determining the Sum of Squares Total.
    difReg = minus(ordinate, regCurve).^2;
    sumDifReg = sum(difReg);

    %Determining the Sum of Squares of Residues.
    difMed = minus(ordinate, medPower).^2;
    sumDifMed = sum(difMed);

    disp("WITHOUT ALGORITHM");
    %Determining the Determination Coeficient.
    coefR2 = (1 -sumDifReg/sumDifMed)*100;
    str = ['Determination Coeficient: ',num2str(coefR2),'%'];
    disp(str);

    %Determining the Determination Coeficient Adjusted.
    coefR2Adj = (1 -(sumDifReg/(samp-xMDim))/(sumDifMed/(samp-1)))*100;
    str = ['Determination Coeficient Adjusted: ',num2str(coefR2Adj),'%'];
    disp(str);
    
    % Plot Difference Between Least Squares and Stock Price.
    figure
    plot((1:samp),diff);
    title('Difference Between Least Squares and Stock Price')

    % Plot Absolute Fourier.
    fourierDiff=fft(diff);
    figure
    plot(abs(fourierDiff));
    title('Absolute FFT of Difference of LS and SM')

    % Interpolation by DFT.
    for n=samp:(samp+sampInterpol)
        YY(n)=0;
         for k=1:samp
         a(k)=real(fourierDiff(k));
         b(k)=-imag(fourierDiff(k));
         omk=2*pi*(k-1)/samp; YY(n)=YY(n)+a(k)*cos(omk*(n-1))+b(k)*sin(omk*(n-1));
         end
        YY(n)=-YY(n)/samp;
    end
    
    % Plot New Stock Curve.
    figure
    plot(1:(samp+sampInterpol), data.price);
    title('Stock Prive vs. Theoretical Price')
    old = [regCurve'  zeros(sampInterpol,1)']';
    
    % Generate the Regression Curve.
        switch order ~=0
        case order == 2
            XX = [ones(samp1,1) abscissa1 abscissa1.^2];
        case order == 3
            XX = [ones(samp1,1) abscissa1 abscissa1.^2 abscissa1.^3];
        case order == 4
            XX = [ones(samp1,1) abscissa1 abscissa1.^2 abscissa1.^3 abscissa.^4];
        case order == 5
            XX = [ones(samp1,1) abscissa1 abscissa1.^2 abscissa1.^3 abscissa1.^4 abscissa1.^5];
    end
    regCurveNew = XX*beta;
    total = regCurveNew+YY';
    hold on;
    plot((1:(samp+sampInterpol)), total);
    hold off;
    
    % Determining the Power Medium.
    medPower = mean(ordinate1);
    
    % Determining the Sum of Squares Total.
    difReg = minus(ordinate1, total).^2;
    sumDifReg = sum(difReg);

    % Determining the Sum of Squares of Residues.
    difMed = minus(ordinate1, medPower).^2;
    sumDifMed = sum(difMed);

    disp("WITH ALGORITHM");
    % Determination Coeficient.
    coefR2 = (1 -sumDifReg/sumDifMed)*100;
    str = ['Determination Coeficient: ',num2str(coefR2),'%'];
    disp(str);

    % Determination Coeficient Adjusted.
    coefR2Adj = (1 -(sumDifReg/(samp1-xMDim))/(sumDifMed/(samp1-1)))*100;
    str = ['Determination Coeficient Adjusted: ',num2str(coefR2Adj),'%'];
    disp(str);
end

function [data] = getStock(symbol, date)
    nameFile =  upper(symbol) + ".csv";
    root = "database/" + nameFile;
    %disp("Get file at: " + root);
    fileID = fopen(root);
    stock = textscan(fileID,"%f %f","Delimiter",',',"TreatAsEmpty",'');
    data.time = stock{1};
    data.price = stock{2};
end
