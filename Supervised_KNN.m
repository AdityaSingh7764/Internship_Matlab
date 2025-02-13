data=readtable('C:\Users\adity\Documents\MATLAB\Social_Network_Ads.csv')

%% Normalization

% Standardization
    standardage=(data.Age-mean(data.Age))/std(data.Age);
    data.Age=standardage
    standardsalary=(data.EstimatedSalary-mean(data.EstimatedSalary))/std(data.EstimatedSalary);
    data.EstimatedSalary=standardsalary

%% KNN Model Implementation
    Model=fitcknn(data,'Purchased~Age+EstimatedSalary');
    % % Test and Train
        Partition=cvpartition(Model.NumObservations,'HoldOut',0.2);
        Cross_Validation=crossval(Model,'cvpartition',Partition);

        Prediction=predict(Cross_Validation.Trained{1}, data(test(Partition), 1:end-1));
    
    %Accuracy checking using confusion matrix
        Results=confusionmat(Cross_Validation.Y(test(Partition)),Prediction);

      
