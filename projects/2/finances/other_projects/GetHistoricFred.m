function [ data ] = GetHistoricFred(symbol,startDate,endDate, show)
%   Produced by Chris Reeves (A2X Capital LLC)
%   Forked by Julio Lima (Universidade Federal do Ceará)
%   Query date ranges from Fred finance.
%   Sample usage: GetHistoricFred('M1','04/27/2010','04/27/2017')
%   Symbols to use: 
%   |-> M1 Money Stock: M1
%   |-> M1 Money Multiplier: MULT
%   |-> S&P 500: SP500
%   |-> Effective Federal Funds Rate: FEDFUNDS
%   |-> Real Personal Consumption Expenditures: PCEC96

    % Checking for optional variables.
    % Display the urls.
    if ~exist('show', 'var')
        show = false;
    end

    %Define a format of query.
    %formatIn = 'dd-mmm-yyyy' or 'mm/dd/yyyy' or 'mm-dd-yyyy'
    formatUrl = 'yyyy-mm-dd';

    %First transform to the number format, it's a generic one.
    startDateNum = datenum(startDate);
    endDateNum = datenum(endDate);

    %First transform to the number format, it's a generic one.
    startDateStr = datestr(startDateNum, formatUrl);
    endDateStr = datestr(endDateNum, formatUrl);

    %Define how much attributes will be used.
    n_attb = 3;
    
    attributes(1) = cellstr(strcat('&id=',symbol));
    attributes(2) = cellstr(strcat('&cosd=',startDateStr));
    attributes(3) = cellstr(strcat('&coed=',endDateStr));

    %Define root of query.
    %Root the url address to download in csv format.
    root = strcat('https://fred.stlouisfed.org/graph/fredgraph.csv?chart_type=');
    
    %Interact root with attributes.
    for i_cat = 1:n_attb
        root = strcat(root,attributes(i_cat));
    end
    
    url = char(root);
    
    %Display address URL.
    if(show)
        disp(url)
    end
    
    %Receive the file.
    response = urlread(url);
    
    %Scan and convert the file to cells and return.
    data_in = textscan(response,'%s %s','delimiter',',','HeaderLines',1);    
    
    %Filter data out by order.
    size_max = size(data_in{1,1});
    n_row = size_max(1,1);
    data = cell(n_row,2);
    data(:,1) = data_in{1,1};
    data(:,2) = data_in{1,2};
    
    %Change datetime format to numbers and override the unreadble parameters.
    try
        i = 1;
        while i<=n_row
            %Change.
            data{i,1} = datenum(data{i,1});
            %Override.
            if(strcmp(data(i,2),'.') || strcmp(data(i,2),'-'))
                data(i,:) = [];
                i = i - 1;
            end
            i = i + 1;
        end
    catch       
    end    
end