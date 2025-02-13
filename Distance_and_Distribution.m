data=readtable('C:\Users\adity\Documents\MATLAB\Social_Network_Ads.csv');

%% Normalization

    Meanage=mean(data.Age,'omitnan');
    Fillage=fillmissing(data.Age,'constant',Meanage);
    data.Age=Fillage;
    Meansalary=mean(data.EstimatedSalary,'omitnan');
    Fillsalary=fillmissing(data.EstimatedSalary,'constant',Meansalary);
    data.EstimatedSalary=Fillsalary;

% Standardization
    % standardage=(data.Age-mean(data.Age))/std(data.Age);
    % data.Age=standardage;
    % standardsalary=(data.EstimatedSalary-mean(data.EstimatedSalary))/std(data.EstimatedSalary);
    % data.EstimatedSalary=standardsalary;

%% KNN Model Implementation with distance parameters

        Model1=fitcknn(data,'Purchased~Age+EstimatedSalary','Distance','cityblock');
        Model2=fitcknn(data,'Purchased~Age+EstimatedSalary','Distance','hamming');
        Model3=fitcknn(data,'Purchased~Age+EstimatedSalary','Distance','chebychev');
        Model4=fitcknn(data,'Purchased~Age+EstimatedSalary','Distance','correlation');
        Model5=fitcknn(data,'Purchased~Age+EstimatedSalary','Distance','jaccard');
        Model6=fitcknn(data,'Purchased~Age+EstimatedSalary','Distance','seuclidean');

        % Test and Train
        Partition1=cvpartition(Model1.NumObservations,'HoldOut',0.2);
        Partition2=cvpartition(Model2.NumObservations,'HoldOut',0.2);
        Partition3=cvpartition(Model3.NumObservations,'HoldOut',0.2);
        Partition4=cvpartition(Model4.NumObservations,'HoldOut',0.2);
        Partition5=cvpartition(Model5.NumObservations,'HoldOut',0.2);
        Partition6=cvpartition(Model6.NumObservations,'HoldOut',0.2);

        Cross_Validation1=crossval(Model1,'cvpartition',Partition1);
        Cross_Validation2=crossval(Model2,'cvpartition',Partition2);
        Cross_Validation3=crossval(Model3,'cvpartition',Partition3);
        Cross_Validation4=crossval(Model4,'cvpartition',Partition4);
        Cross_Validation5=crossval(Model5,'cvpartition',Partition5);
        Cross_Validation6=crossval(Model6,'cvpartition',Partition6);
        
        Prediction1=predict(Cross_Validation1.Trained{1}, data(test(Partition1), 1:end-1));
        Prediction2=predict(Cross_Validation2.Trained{1}, data(test(Partition2), 1:end-1));
        Prediction3=predict(Cross_Validation3.Trained{1}, data(test(Partition3), 1:end-1));
        Prediction4=predict(Cross_Validation4.Trained{1}, data(test(Partition4), 1:end-1));
        Prediction5=predict(Cross_Validation5.Trained{1}, data(test(Partition5), 1:end-1));
        Prediction6=predict(Cross_Validation6.Trained{1}, data(test(Partition6), 1:end-1));
        
        % Accuracy checking using confusion matrix
           Result1=confusionmat(Cross_Validation1.Y(test(Partition1)),Prediction1);
           Result2=confusionmat(Cross_Validation2.Y(test(Partition2)),Prediction2);
           Result3=confusionmat(Cross_Validation3.Y(test(Partition3)),Prediction3);
           Result4=confusionmat(Cross_Validation4.Y(test(Partition4)),Prediction4);
           Result5=confusionmat(Cross_Validation5.Y(test(Partition5)),Prediction5);
           Result6=confusionmat(Cross_Validation6.Y(test(Partition6)),Prediction6);

 %% Naive Bayes Implementation with Distribution parameters

        Model7=fitcnb(data,'Purchased~Age+EstimatedSalary','DistributionNames','kernel');
        Model8=fitcnb(data,'Purchased~Age+EstimatedSalary','DistributionNames','mn');
        % Model9=fitcnb(data,'Purchased~Age+EstimatedSalary','DistributionNames','mvmn');
        Model10=fitcnb(data,'Purchased~Age+EstimatedSalary','DistributionNames','normal');

        % Test and Train
        Partition7=cvpartition(Model7.NumObservations,'HoldOut',0.2);
        Partition8=cvpartition(Model8.NumObservations,'HoldOut',0.2);
        % Partition9=cvpartition(Model9.NumObservations,'HoldOut',0.2);
        Partition10=cvpartition(Model10.NumObservations,'HoldOut',0.2);

        Cross_Validation7=crossval(Model7,'cvpartition',Partition7);
        Cross_Validation8=crossval(Model8,'cvpartition',Partition8);
        % Cross_Validation9=crossval(Model9,'cvpartition',Partition9);
        Cross_Validation10=crossval(Model10,'cvpartition',Partition10);
        
        Prediction7=predict(Cross_Validation7.Trained{1}, data(test(Partition7), 1:end-1));
        Prediction8=predict(Cross_Validation8.Trained{1}, data(test(Partition8), 1:end-1));
        % Prediction9=predict(Cross_Validation9.Trained{1}, data(test(Partition9), 1:end-1));
        Prediction10=predict(Cross_Validation10.Trained{1}, data(test(Partition10), 1:end-1));

        % Accuracy checking using confusion matrix
           Result7=confusionmat(Cross_Validation7.Y(test(Partition7)),Prediction7);
           Result8=confusionmat(Cross_Validation8.Y(test(Partition8)),Prediction8);
           % Result9=confusionmat(Cross_Validation9.Y(test(Partition9)),Prediction9);
           Result10=confusionmat(Cross_Validation10.Y(test(Partition10)),Prediction10);
 

