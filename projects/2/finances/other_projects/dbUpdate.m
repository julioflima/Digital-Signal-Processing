function dbUpdate(show)
%	Update all parameters in database from Google or Fred and Brasil.
    
    % Checking for optional endDate.
    if ~exist('show', 'var')
        show = false;
    end
    
    %M1 Money Stock - EUA
    oneUpdate('M1','01/06/1975', show);
    
    %M1 Money Multiplier
    oneUpdate('MULT','02/15/1984', show);
    
    %S&P 500
    oneUpdate('SP500','06/29/2007', show);
    
    %Effective Federal Funds Rate
    oneUpdate('FEDFUNDS','07/01/1954', show);

    %Real Personal Consumption Expenditures
    oneUpdate('PCEC96','01/01/1999', show);
       
    %Selic Annualyzed Percetual Monthly: 4189
    oneUpdate('SGS4189',show);
    
    %Selic Annualyzed Percetual Daily: 1178
    oneUpdate('SGS1178',show);
    
    %Selic Percetual Monthly: 4390
    oneUpdate('SGS4390',show);
    
    %Selic Percetual Daily: 11
    oneUpdate('SGS11',show);
    
    %SPY
    oneUpdate('SPY','12/01/2005', show);  
    
    %Banco do Brasil
    oneUpdate('BBAS3','06/13/2003', show);
    
    %Petrobras
    oneUpdate('PETR4','06/13/2003', show); 
    
    %Ibovespa
    oneUpdate('IBOV','06/13/2003', show); 
    
    %Itau
    oneUpdate('ITUB4','06/13/2003', show); 
    
    
    %Informative.
    disp('DONE!');
end