% Method 1 Deleting missing value

    % data=readtable('C:\Users\adity\Documents\MATLAB\Data_1')
    % Newdata=rmmissing(data)

% Method 2 Mean

    % Meanage=mean(data.Age,'omitnan');
    % Fillage=fillmissing(data.Age,'constant',Meanage);
    % data.Age=Fillage
    % Meanannualsalary=mean(data.AnnualSalary,'omitnan');
    % Fillannualsalary=fillmissing(data.AnnualSalary,'constant',Meanannualsalary);
    % data.AnnualSalary=Fillannualsalary

% Dealing with categorical data

    % data=readtable('C:\Users\adity\Documents\MATLAB\Data_3.csv')
    % data.Opinion=categorical(data.Opinion);
    % modeopinion=mode(data.Opinion);
    % modemissing=fillmissing(data.Opinion,'constant',cellstr(modeopinion));
    % data.Opinion=modemissing

% Feature_Selection

    % data=readtable('C:\Users\adity\Documents\MATLAB\Data_4')
    % Standardization

        % standardage=(data.Age-mean(data.Age))/std(data.Age);
        % data.Age=standardage
        
        % standardsalary=(data.AnnualSalary-mean(data.AnnualSalary))/std(data.AnnualSalary);
        % data.AnnualSalary=standardsalary

    % Normalization

        % normalizeage=(data.Age-min(data.Age))/(max(data.Age)-min(data.Age));
        % data.Age=normalizeage
        
        % normalizesalary=(data.AnnualSalary-min(data.AnnualSalary))/(max(data.AnnualSalary)-min(data.AnnualSalary));
        % data.AnnualSalary=normalizesalary
   
 
