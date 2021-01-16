function oneUpdate(symbol,startDate, endDate,show)
%   Update some parameter from Google or Fred.  
    
    % Checking for optional endDate.
    if ~exist('show', 'var')
        show = false;
        if (exist('startDate', 'var') && islogical(startDate))
            show = startDate;
        end
        if (exist('endDate', 'var') && islogical(endDate))
            show = endDate;
            endDate = today('datetime');
        end
    end
    
    if ~exist('endDate', 'var')
        endDate = today('datetime'); 
    end
    
    %Define root of db;
    root = strcat('database/',symbol,'.csv');
    
    %Find the Extern Database that match;
    try
       if(~exist('startDate', 'var') || exist('startDate', 'var') && ~islogical(startDate))
           try
               data = GetHistoricFred(symbol,startDate,endDate, show);
           catch Exp1
               if(strcmp(Exp1.identifier,'MATLAB:urlread:ConnectionFailed'))
                   try
                       data = GetHistoricGoogle(symbol,startDate,endDate, show);
                   catch Exp2
                       disp(Exp2);
                   end
               else
                   disp(Exp1);
               end
           end
       else
           try
               data = GetHistoricBrasil(symbol,show);
           catch Exp3
               disp(Exp3);
           end
       end
        
       if (exist(root, 'file') == 2)
           n_row =  size(data);
           n_row_csv =  size(csvread(root));
           if(n_row_csv(1,1) < n_row(1,1))
               cell2csv(root,data);
               disp(strcat(symbol,' - Updated.'));
           elseif (n_row_csv(1,1) == n_row(1,1))
               disp(strcat(symbol,' - It''s already updated'));
           else
               disp(strcat(symbol,' - Not updated.'));
           end
       else
           cell2csv(root,data);
           disp(strcat(symbol,' - Created.'));
       end
       
    catch MExc
        disp(MExc)
    end
end