data1=readtable('C:\Users\adity\Documents\MATLAB\imdb_movies.csv');
data2=readtable('C:\Users\adity\Documents\MATLAB\smartphones_cleaned_v6.csv');

% Method 1 Deleting missing value
     % Newdata1=rmmissing(data1)
     % Newdata2=rmmissing(data2)

%% Method 2 Mean

    MeanBudget=mean(data1.budget_x,'omitnan');
    FillBudget=fillmissing(data1.budget_x,'constant',MeanBudget);
    data1.budget_x=FillBudget;
    
    MeanRevenue=mean(data1.revenue,'omitnan');
    FillRevenue=fillmissing(data1.revenue,'constant',MeanRevenue);
    data1.revenue=FillRevenue

    MeanPrice=mean(data2.price,'omitnan');
    FillPrice=fillmissing(data2.price,'constant',MeanPrice);
    data2.price=FillPrice;

    MeanRating=mean(data2.rating,'omitnan');
    FillRating=fillmissing(data2.rating,'constant',MeanRating);
    data2.rating=FillRating

%% Feature_Selection

    %Standardization
         
        StandardBudget=(data1.budget_x-mean(data1.budget_x))/std(data1.budget_x);
        data1.budget_x=StandardBudget
        
        StandardRevenue=(data1.revenue-mean(data1.revenue))/std(data1.revenue);
        data1.revenue=StandardRevenue

        StandardPrice=(data2.price-mean(data2.price))/std(data2.price);
        data2.price=StandardPrice
        
        StandardRating=(data2.rating-mean(data2.rating))/std(data2.rating);
        data2.rating=StandardRating
 %% KNN Model Implementation
    Model1=fitcknn(data1,'status~budget_x+revenue');
    Model2=fitcknn(data2,'has_5g~price+rating');
    % Test and Train
        Partition1=cvpartition(Model1.NumObservations,'HoldOut',0.25);
        Partition2=cvpartition(Model2.NumObservations,'HoldOut',0.25);
        Cross_Validation1=crossval(Model1,'cvpartition',Partition1);
        Cross_Validation2=crossval(Model2,'cvpartition',Partition2);

        Prediction1=predict(Cross_Validation1.Trained{1}, data1(test(Partition1), 1:end-1));
        Prediction2=predict(Cross_Validation2.Trained{1}, data2(test(Partition2), 1:end-1));
    
    % Accuracy checking using confusion matrix
        Result1=confusionmat(Cross_Validation1.Y(test(Partition1)),Prediction1);
        Result2=confusionmat(Cross_Validation2.Y(test(Partition2)),Prediction2);

       
