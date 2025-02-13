data1=readtable('C:\Users\adity\Documents\MATLAB\alzheimers_disease_data.csv');

% Method 1 Deleting missing value
    Newdata1=rmmissing(data1);

% Method 2 Mean

    MeanAge=mean(data1.Age,'omitnan');
    FillAge=fillmissing(data1.Age,'constant',MeanAge);
    data1.Age=FillAge;

    MeanBmi=mean(data1.BMI,'omitnan');
    FillBmi=fillmissing(data1.BMI,'constant',MeanBmi);
    data1.BMI=FillBmi;

%% Feature_Selection

    %Standardization

        standardage=(data1.Age-mean(data1.Age))/std(data1.Age);
        data1.Age=standardage

        standardBMI=(data1.BMI-mean(data1.BMI))/std(data1.BMI);
        data1.BMI=standardBMI

    % Normalization

        % normalizeage=(data.Age-min(data.Age))/(max(data.Age)-min(data.Age));
        % data.Age=normalizeage
        
        % normalizesalary=(data.AnnualSalary-min(data.AnnualSalary))/(max(data.AnnualSalary)-min(data.AnnualSalary));
        % data.AnnualSalary=normalizesalary
        
