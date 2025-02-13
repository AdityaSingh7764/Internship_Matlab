data=readtable('C:\Users\adity\Documents\MATLAB\Social_Network_Ads.csv')

%% Normalization

% Standardization
    standardage=(data.Age-mean(data.Age))/std(data.Age);
    data.Age=standardage
    standardsalary=(data.EstimatedSalary-mean(data.EstimatedSalary))/std(data.EstimatedSalary);
    data.EstimatedSalary=standardsalary

%% KNN Model Implementation with parameters
 
       %Accuracy:(TP+TN)/(TP+TN+FP+FN)
       %Precision:TP/(TP+FP)
       %Recall (Sensitivity): TP/(TP+FN)
       %F1 Score: 2x((PrecisionxRecall) /(Precision +Recall))

        Model1=fitcknn(data,'Purchased~Age+EstimatedSalary','Distance','chebychev');
        % Test and Train
        Partition1=cvpartition(Model1.NumObservations,'HoldOut',0.2);
        Cross_Validation1=crossval(Model1,'cvpartition',Partition1);
        Prediction1=predict(Cross_Validation1.Trained{1}, data(test(Partition1), 1:end-1));
        % Accuracy checking using confusion matrix
           Result1=confusionmat(Cross_Validation1.Y(test(Partition1)),Prediction1);

        %% Breakties Condition

        Model2=fitcknn(data,'Purchased~Age+EstimatedSalary','BreakTies','smallest');
        Partition2=cvpartition(Model2.NumObservations,'HoldOut',0.2);
        Cross_Validation2=crossval(Model2,'cvpartition',Partition2);
        Prediction2=predict(Cross_Validation2.Trained{1}, data(test(Partition2), 1:end-1));
        % Accuracy checking using confusion matrix
            
            Result2=confusionmat(Cross_Validation2.Y(test(Partition2)),Prediction2);