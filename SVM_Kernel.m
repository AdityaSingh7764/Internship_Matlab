data=readtable('C:\Users\adity\Documents\MATLAB\Data_3.csv');

    Meanage=mean(data.Age,'omitnan');
    Fillage=fillmissing(data.Age,'constant',Meanage);
    data.Age=Fillage;
    Meansalary=mean(data.AnnualSalary,'omitnan');
    Fillsalary=fillmissing(data.AnnualSalary,'constant',Meansalary);
    data.AnnualSalary=Fillsalary;

    standardage=(data.Age-mean(data.Age))/std(data.Age);
    data.Age=standardage;

    standardsalary=(data.AnnualSalary-mean(data.AnnualSalary))/std(data.AnnualSalary);
    data.AnnualSalary=standardsalary;

    data = rmmissing(data, 'DataVariables', {'Opinion'});

%% SVM Model Implementation
    %Kernal Function
    Model1=fitcsvm(data,'Opinion~Age+AnnualSalary','KernelFunction','linear');
    Model2=fitcsvm(data,'Opinion~Age+AnnualSalary','KernelFunction','gaussian');
    Model3=fitcsvm(data,'Opinion~Age+AnnualSalary','KernelFunction','rbf');
    Model4=fitcsvm(data,'Opinion~Age+AnnualSalary','KernelFunction','polynomial');


    %% Test and Train
        Partition1=cvpartition(size(data,1), 'HoldOut', 0.2);
        Partition2=cvpartition(size(data,1), 'HoldOut', 0.2);
        Partition3=cvpartition(size(data,1), 'HoldOut', 0.2);
        Partition4=cvpartition(size(data,1), 'HoldOut', 0.2);

        Cross_Validation1=crossval(Model1,'cvpartition',Partition1);
        Cross_Validation2=crossval(Model2,'cvpartition',Partition2);
        Cross_Validation3=crossval(Model3,'cvpartition',Partition3);
        Cross_Validation4=crossval(Model4,'cvpartition',Partition4);

        Prediction1=predict(Cross_Validation1.Trained{1}, data(test(Partition1),1:end-1));
        Prediction2=predict(Cross_Validation2.Trained{1}, data(test(Partition2),1:end-1));
        Prediction3=predict(Cross_Validation3.Trained{1}, data(test(Partition3),1:end-1));
        Prediction4=predict(Cross_Validation4.Trained{1}, data(test(Partition4),1:end-1));

    %Accuracy checking using confusion matrix
        Result1=confusionmat(Cross_Validation1.Y(test(Partition1)),Prediction1);
        Result2=confusionmat(Cross_Validation2.Y(test(Partition2)),Prediction2);
        Result3=confusionmat(Cross_Validation3.Y(test(Partition3)),Prediction3);
        Result4=confusionmat(Cross_Validation4.Y(test(Partition4)),Prediction4);


%% -------------- Visualizing training set results --------------
%  ---------------------------- Code ---------------------------

unique_labels = unique(data.Opinion);
labels = cellstr(unique_labels);

%% Figure 1

figure;
classifier_name = 'SVM Model 1(Training)';

Age_range_1 = min(data.Age(training(Partition1)))-1:0.01:max(data.Age(training(Partition1)))+1;
Salary_range_1 = min(data.AnnualSalary(training(Partition1)))-1:0.01:max(data.AnnualSalary(training(Partition1)))+1;

[xx1, xx2] = meshgrid(Age_range_1,Salary_range_1);
XGrid1 = [xx1(:) xx2(:)]; 

predictions_meshgrid1 = predict(Cross_Validation1.Trained{1},XGrid1);

gscatter(xx1(:), xx2(:), predictions_meshgrid1,'rgb');
hold on
training_data1 = data(training(Partition1),:);

Y1 = ismember(training_data1.Opinion,labels{1});

scatter(training_data1.Age(Y1),training_data1.AnnualSalary(Y1), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data1.Age(~Y1),training_data1.AnnualSalary(~Y1) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Age');
ylabel('Annual Salary');

title(classifier_name);
hold off;
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 2

figure;
classifier_name = 'SVM Model 2 (Training)';

Age_range_2 = min(data.Age(training(Partition2)))-1:0.01:max(data.Age(training(Partition2)))+1;
Salary_range_2 = min(data.AnnualSalary(training(Partition2)))-1:0.01:max(data.AnnualSalary(training(Partition2)))+1;

[xx3, xx4] = meshgrid(Age_range_2,Salary_range_2);
XGrid2 = [xx3(:) xx4(:)]; 

predictions_meshgrid2 = predict(Cross_Validation2.Trained{1},XGrid2);

gscatter(xx3(:), xx4(:), predictions_meshgrid2,'rgb');
hold on
training_data2 = data(training(Partition2),:);

Y2 = ismember(training_data2.Opinion,labels{1});

scatter(training_data2.Age(Y2),training_data1.AnnualSalary(Y2), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data2.Age(~Y2),training_data1.AnnualSalary(~Y2) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Age');
ylabel('Annual Salary');

title(classifier_name);
hold off;
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight 

%% Figure 3

figure;
classifier_name = 'SVM Model 3(Training)';

Age_range_3 = min(data.Age(training(Partition3)))-1:0.01:max(data.Age(training(Partition3)))+1;
Salary_range_3 = min(data.AnnualSalary(training(Partition3)))-1:0.01:max(data.AnnualSalary(training(Partition3)))+1;

[xx5, xx6] = meshgrid(Age_range_3,Salary_range_3);
XGrid3 = [xx5(:) xx6(:)]; 

predictions_meshgrid3 = predict(Cross_Validation3.Trained{1},XGrid3);

gscatter(xx5(:), xx6(:), predictions_meshgrid3,'rgb');
hold on
training_data3 = data(training(Partition3),:);

Y3 = ismember(training_data3.Opinion,labels{1});

scatter(training_data3.Age(Y3),training_data1.AnnualSalary(Y3), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data3.Age(~Y3),training_data1.AnnualSalary(~Y3) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Age');
ylabel('Annual Salary');

title(classifier_name);
hold off;
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 4

figure;
classifier_name = 'SVM Model 4(Training)';

Age_range_4 = min(data.Age(training(Partition4)))-1:0.01:max(data.Age(training(Partition4)))+1;
Salary_range_4 = min(data.AnnualSalary(training(Partition4)))-1:0.01:max(data.AnnualSalary(training(Partition4)))+1;

[xx7, xx8] = meshgrid(Age_range_4,Salary_range_4);
XGrid4 = [xx7(:) xx8(:)]; 

predictions_meshgrid4 = predict(Cross_Validation4.Trained{1},XGrid4);

gscatter(xx7(:), xx8(:), predictions_meshgrid4,'rgb');
hold on
training_data4 = data(training(Partition4),:);

Y4 = ismember(training_data4.Opinion,labels{1});

scatter(training_data4.Age(Y4),training_data4.AnnualSalary(Y4), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data4.Age(~Y4),training_data4.AnnualSalary(~Y4) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Age');
ylabel('Annual Salary');

title(classifier_name);
hold off;
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight
%% -------------- Visualizing testing set results ----------------
% ---------------------------- Code ---------------------------

%% Figure 1

figure;
classifier_name = 'SVM Model 1(Testing)';

Age_range_1 = min(data.Age(training(Partition1)))-1:0.01:max(data.Age(training(Partition1)))+1;
Salary_range_1 = min(data.AnnualSalary(training(Partition1)))-1:0.01:max(data.AnnualSalary(training(Partition1)))+1;

[xx1, xx2] = meshgrid(Age_range_1,Salary_range_1);
XGrid1 = [xx1(:) xx2(:)];

predictions_meshgrid1 = predict(Cross_Validation1.Trained{1},XGrid1);

gscatter(xx1(:), xx2(:), predictions_meshgrid1,'rgb');
hold on
testing_data1 =  data(test(Partition1),:);

Y1 = ismember(testing_data1.Opinion,labels{1});

scatter(testing_data1.Age(Y1),testing_data1.Age(Y1), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data1.AnnualSalary(~Y1),testing_data1.AnnualSalary(~Y1) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Age');
ylabel('Annual Salary');

title(classifier_name);
legend off, 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 2

figure;
classifier_name = 'SVM Model 2(Testing)';

Age_range_2 = min(data.Age(training(Partition2)))-1:0.01:max(data.Age(training(Partition2)))+1;
Salary_range_2 = min(data.AnnualSalary(training(Partition2)))-1:0.01:max(data.AnnualSalary(training(Partition2)))+1;

[xx3, xx4] = meshgrid(Age_range_2,Salary_range_2);
XGrid2 = [xx3(:) xx4(:)];

predictions_meshgrid2 = predict(Cross_Validation2.Trained{1},XGrid2);

gscatter(xx3(:), xx4(:), predictions_meshgrid2,'rgb');
hold on
testing_data2 =  data(test(Partition2),:);

Y2 = ismember(testing_data2.Opinion,labels{1});

scatter(testing_data2.Age(Y2),testing_data1.Age(Y2), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data2.AnnualSalary(~Y2),testing_data1.AnnualSalary(~Y2) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Age');
ylabel('Annual Salary');

title(classifier_name);
legend off, 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 3

figure;
classifier_name = 'SVM Model 3(Testing)';

Age_range_3 = min(data.Age(training(Partition3)))-1:0.01:max(data.Age(training(Partition3)))+1;
Salary_range_3 = min(data.AnnualSalary(training(Partition3)))-1:0.01:max(data.AnnualSalary(training(Partition3)))+1;

[xx5, xx6] = meshgrid(Age_range_3,Salary_range_3);
XGrid3 = [xx5(:) xx6(:)];

predictions_meshgrid3 = predict(Cross_Validation3.Trained{1},XGrid3);

gscatter(xx5(:), xx6(:), predictions_meshgrid3,'rgb');
hold on
testing_data3 =  data(test(Partition3),:);

Y3 = ismember(testing_data3.Opinion,labels{1});

scatter(testing_data3.Age(Y3),testing_data3.Age(Y3), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data3.AnnualSalary(~Y3),testing_data3.AnnualSalary(~Y3) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Age');
ylabel('Annual Salary');

title(classifier_name);
legend off, 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 4

figure;
classifier_name = 'SVM Model 4(Testing)';

Age_range_4 = min(data.Age(training(Partition4)))-1:0.01:max(data.Age(training(Partition4)))+1;
Salary_range_4 = min(data.AnnualSalary(training(Partition4)))-1:0.01:max(data.AnnualSalary(training(Partition4)))+1;

[xx7, xx8] = meshgrid(Age_range_4,Salary_range_4);
XGrid4 = [xx7(:) xx8(:)];

predictions_meshgrid4 = predict(Cross_Validation4.Trained{1},XGrid4);

gscatter(xx7(:), xx8(:), predictions_meshgrid4,'rgb');
hold on
testing_data4 =  data(test(Partition4),:);

Y4 = ismember(testing_data4.Opinion,labels{1});

scatter(testing_data4.Age(Y4),testing_data4.Age(Y4), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data4.AnnualSalary(~Y4),testing_data4.AnnualSalary(~Y4) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Age');
ylabel('Annual Salary');

title(classifier_name);
legend off, 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight





%% Smartphone



data=readtable('C:\Users\adity\Documents\MATLAB\smartphones_cleaned_v6.csv');

    Meanprice=mean(data.price,'omitnan');
    Fillprice=fillmissing(data.price,'constant',Meanprice);
    data.price=Fillprice;
    Meanrating=mean(data.rating,'omitnan');
    Fillrating=fillmissing(data.rating,'constant',Meanrating);
    data.rating=Fillrating;

    standardprice=(data.price-mean(data.price))/std(data.price);
    data.price=standardprice;

    standardrating=(data.rating-mean(data.rating))/std(data.rating);
    data.rating=standardrating;

    data = rmmissing(data, 'DataVariables', {'has_5g'});

%% SVM Model Implementation
    %Kernal Function
    Model1=fitcsvm(data,'has_5g~price+rating','KernelFunction','linear');
    Model2=fitcsvm(data,'has_5g~price+rating','KernelFunction','gaussian');
    Model3=fitcsvm(data,'has_5g~price+rating','KernelFunction','rbf');
    Model4=fitcsvm(data,'has_5g~price+rating','KernelFunction','polynomial');


    %% Test and Train
        Partition1=cvpartition(size(data,1), 'HoldOut', 0.2);
        Partition2=cvpartition(size(data,1), 'HoldOut', 0.2);
        Partition3=cvpartition(size(data,1), 'HoldOut', 0.2);
        Partition4=cvpartition(size(data,1), 'HoldOut', 0.2);

        Cross_Validation1=crossval(Model1,'cvpartition',Partition1);
        Cross_Validation2=crossval(Model2,'cvpartition',Partition2);
        Cross_Validation3=crossval(Model3,'cvpartition',Partition3);
        Cross_Validation4=crossval(Model4,'cvpartition',Partition4);

        Prediction1=predict(Cross_Validation1.Trained{1}, data(test(Partition1),1:end-1));
        Prediction2=predict(Cross_Validation2.Trained{1}, data(test(Partition2),1:end-1));
        Prediction3=predict(Cross_Validation3.Trained{1}, data(test(Partition3),1:end-1));
        Prediction4=predict(Cross_Validation4.Trained{1}, data(test(Partition4),1:end-1));

    %Accuracy checking using confusion matrix
        Result1=confusionmat(Cross_Validation1.Y(test(Partition1)),Prediction1);
        Result2=confusionmat(Cross_Validation2.Y(test(Partition2)),Prediction2);
        Result3=confusionmat(Cross_Validation3.Y(test(Partition3)),Prediction3);
        Result4=confusionmat(Cross_Validation4.Y(test(Partition4)),Prediction4);


%% -------------- Visualizing training set results --------------
%  ---------------------------- Code ---------------------------

unique_labels = unique(data.has_5g);
labels = cellstr(unique_labels);

%% Figure 1

figure;
classifier_name = 'SVM Model 1(Training)';

Price_range_1 = min(data.price(training(Partition1)))-1:0.01:max(data.price(training(Partition1)))+1;
Rating_range_1 = min(data.rating(training(Partition1)))-1:0.01:max(data.rating(training(Partition1)))+1;

[xx1, xx2] = meshgrid(Price_range_1,Rating_range_1);
XGrid1 = [xx1(:) xx2(:)]; 

predictions_meshgrid1 = predict(Cross_Validation1.Trained{1},XGrid1);

gscatter(xx1(:), xx2(:), predictions_meshgrid1,'rgb');
hold on
training_data1 = data(training(Partition1),:);

Y1 = ismember(training_data1.has_5g,labels{1});

scatter(training_data1.price(Y1),training_data1.rating(Y1), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data1.price(~Y1),training_data1.rating(~Y1) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Price');
ylabel('Rating');

title(classifier_name);
hold off;
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 2

figure;
classifier_name = 'SVM Model 2 (Training)';

Price_range_2 = min(data.price(training(Partition2)))-1:0.01:max(data.price(training(Partition2)))+1;
Rating_range_2 = min(data.rating(training(Partition2)))-1:0.01:max(data.rating(training(Partition2)))+1;

[xx3, xx4] = meshgrid(Price_range_2,Rating_range_2);
XGrid2 = [xx3(:) xx4(:)]; 

predictions_meshgrid2 = predict(Cross_Validation2.Trained{1},XGrid2);

gscatter(xx3(:), xx4(:), predictions_meshgrid2,'rgb');
hold on
training_data2 = data(training(Partition2),:);

Y2 = ismember(training_data2.has_5g,labels{1});

scatter(training_data1.price(Y2),training_data1.rating(Y2), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data1.price(~Y2),training_data1.rating(~Y2) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Price');
ylabel('Rating');

title(classifier_name);
hold off;
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 3

figure;
classifier_name = 'SVM Model 3(Training)';

Price_range_3 = min(data.price(training(Partition3)))-1:0.01:max(data.price(training(Partition3)))+1;
Rating_range_3 = min(data.rating(training(Partition3)))-1:0.01:max(data.rating(training(Partition3)))+1;

[xx5, xx6] = meshgrid(Price_range_3,Rating_range_3);
XGrid3 = [xx5(:) xx6(:)]; 

predictions_meshgrid3 = predict(Cross_Validation3.Trained{1},XGrid3);

gscatter(xx5(:), xx6(:), predictions_meshgrid3,'rgb');
hold on
training_data3 = data(training(Partition3),:);

Y3 = ismember(training_data3.has_5g,labels{1});

scatter(training_data3.price(Y3),training_data1.rating(Y3), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data3.price(~Y3),training_data1.rating(~Y3) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Price');
ylabel('Rating');

title(classifier_name);
hold off;
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 4

figure;
classifier_name = 'SVM Model 4(Training)';

Price_range_4 = min(data.price(training(Partition4)))-1:0.01:max(data.price(training(Partition4)))+1;
Rating_range_4 = min(data.rating(training(Partition4)))-1:0.01:max(data.rating(training(Partition4)))+1;

[xx7, xx8] = meshgrid(Price_range_4,Rating_range_4);
XGrid4 = [xx7(:) xx8(:)]; 

predictions_meshgrid4 = predict(Cross_Validation4.Trained{1},XGrid4);

gscatter(xx7(:), xx8(:), predictions_meshgrid4,'rgb');
hold on
training_data4 = data(training(Partition4),:);

Y4 = ismember(training_data4.has_5g,labels{1});

scatter(training_data4.price(Y4),training_data1.rating(Y4), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data4.price(~Y4),training_data1.rating(~Y4) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Price');
ylabel('Rating');

title(classifier_name);
hold off;
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% -------------- Visualizing testing set results ----------------
% ---------------------------- Code ---------------------------

%% Figure 1

figure;
classifier_name = 'SVM Model 1(Testing)';

Price_range_1 = min(data.price(training(Partition1)))-1:0.01:max(data.price(training(Partition1)))+1;
Rating_range_1 = min(data.rating(training(Partition1)))-1:0.01:max(data.rating(training(Partition1)))+1;

[xx1, xx2] = meshgrid(Price_range_1,Rating_range_1);
XGrid1 = [xx1(:) xx2(:)];

predictions_meshgrid1 = predict(Cross_Validation1.Trained{1},XGrid1);

gscatter(xx1(:), xx2(:), predictions_meshgrid1,'rgb');
hold on
testing_data1 =  data(test(Partition1),:);

Y1 = ismember(testing_data1.has_5g,labels{1});

scatter(testing_data1.price(Y1),testing_data1.price(Y1), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data1.rating(~Y1),testing_data1.rating(~Y1) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Age');
ylabel('Annual Salary');

title(classifier_name);
legend off, 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 2

figure;
classifier_name = 'SVM Model 2(Testing)';

Price_range_2 = min(data.price(training(Partition2)))-1:0.01:max(data.price(training(Partition2)))+1;
Rating_range_2 = min(data.rating(training(Partition2)))-1:0.01:max(data.rating(training(Partition2)))+1;

[xx3, xx4] = meshgrid(Price_range_2,Rating_range_2);
XGrid2 = [xx3(:) xx4(:)];

predictions_meshgrid2 = predict(Cross_Validation2.Trained{1},XGrid2);

gscatter(xx3(:), xx4(:), predictions_meshgrid2,'rgb');
hold on
testing_data2 =  data(test(Partition2),:);

Y2 = ismember(testing_data2.has_5g,labels{1});

scatter(testing_data2.price(Y2),testing_data2.price(Y2), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data2.rating(~Y2),testing_data2.rating(~Y2) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Age');
ylabel('Annual Salary');

title(classifier_name);
legend off, 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 3

figure;
classifier_name = 'SVM Model 3(Testing)';

Price_range_3 = min(data.price(training(Partition3)))-1:0.01:max(data.price(training(Partition3)))+1;
Rating_range_3 = min(data.rating(training(Partition3)))-1:0.01:max(data.rating(training(Partition3)))+1;

[xx5, xx6] = meshgrid(Price_range_3,Rating_range_3);
XGrid3 = [xx5(:) xx6(:)];

predictions_meshgrid3 = predict(Cross_Validation3.Trained{1},XGrid3);

gscatter(xx5(:), xx6(:), predictions_meshgrid3,'rgb');
hold on
testing_data3 =  data(test(Partition3),:);

Y3 = ismember(testing_data3.has_5g,labels{1});

scatter(testing_data3.price(Y3),testing_data3.price(Y3), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data3.rating(~Y3),testing_data3.rating(~Y3) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Age');
ylabel('Annual Salary');

title(classifier_name);
legend off, 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 4

figure;
classifier_name = 'SVM Model 4(Testing)';

Price_range_4 = min(data.price(training(Partition4)))-1:0.01:max(data.price(training(Partition4)))+1;
Rating_range_4 = min(data.rating(training(Partition4)))-1:0.01:max(data.rating(training(Partition4)))+1;

[xx7, xx8] = meshgrid(Price_range_4,Rating_range_4);
XGrid4 = [xx7(:) xx8(:)];

predictions_meshgrid4 = predict(Cross_Validation4.Trained{1},XGrid4);

gscatter(xx7(:), xx8(:), predictions_meshgrid4,'rgb');
hold on
testing_data4 =  data(test(Partition4),:);

Y4 = ismember(testing_data4.has_5g,labels{1});

scatter(testing_data4.price(Y4),testing_data4.price(Y4), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data4.rating(~Y4),testing_data4.rating(~Y4) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Age');
ylabel('Annual Salary');

title(classifier_name);
legend off, 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight
