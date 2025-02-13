data=readtable('C:\Users\adity\Documents\MATLAB\World Population by country 2024_dataset.csv');

    Meanpopulation2024=mean(data.Population2024,'omitnan');
    Fillpopulation2024=fillmissing(data.Population2024,'constant',Meanpopulation2024);
    data.Population2024=Fillpopulation2024;
    Meanpopulation2023=mean(data.Population2023,'omitnan');
    Fillpopulation2023=fillmissing(data.Population2023,'constant',Meanpopulation2023);
    data.Population2023=Fillpopulation2023;

    standardpopulation2024=(data.Population2024-mean(data.Population2024))/std(data.Population2024);
    data.Population2024=standardpopulation2024;

    standardpopulation2023=(data.Population2023-mean(data.Population2023))/std(data.Population2023);
    data.Population2023=standardpopulation2023;

    data = rmmissing(data, 'DataVariables', {'WorldRank'});

%% Decision Tree Model Implementation
    %Split Criteria
    Model1=fitctree(data,'WorldRank~Population2024+Population2023','SplitCriterion','gdi');
    Model2=fitctree(data,'WorldRank~Population2024+Population2023','SplitCriterion','twoing');
    Model3=fitctree(data,'WorldRank~Population2024+Population2023','SplitCriterion','deviance');
    
    %% Test and Train
        Partition1=cvpartition(size(data,1), 'HoldOut', 0.2);
        Partition2=cvpartition(size(data,1), 'HoldOut', 0.2);
        Partition3=cvpartition(size(data,1), 'HoldOut', 0.2);

        Cross_Validation1=crossval(Model1,'cvpartition',Partition1);
        Cross_Validation2=crossval(Model2,'cvpartition',Partition2);
        Cross_Validation3=crossval(Model3,'cvpartition',Partition3);

        Prediction1=predict(Cross_Validation1.Trained{1}, data(test(Partition1),:));
        Prediction2=predict(Cross_Validation2.Trained{1}, data(test(Partition2), :));
        Prediction3=predict(Cross_Validation3.Trained{1}, data(test(Partition3), :));
    
    %Accuracy checking using confusion matrix
        Result1=confusionmat(Cross_Validation1.Y(test(Partition1)),Prediction1);
        Result2=confusionmat(Cross_Validation2.Y(test(Partition2)),Prediction2);
        Result3=confusionmat(Cross_Validation3.Y(test(Partition3)),Prediction3);


%% -------------- Visualizing training set results --------------
%  ---------------------------- Code ---------------------------
 
unique_labels = unique(data.WorldRank);
labels = cellstr(num2str(unique_labels));

%% Figure 1

figure;
classifier_name = 'Decision Tree Model 1(Training)';

Population2024_range_1 = min(data.Population2024(training(Partition1)))-1:0.01:max(data.Population2024(training(Partition1)))+1;
Population2023_range_1 = min(data.Population2023(training(Partition1)))-1:0.01:max(data.Population2023(training(Partition1)))+1;

[xx1, xx2] = meshgrid(Population2024_range_1,Population2023_range_1);
XGrid1 = [xx1(:) xx2(:)]; 

predictions_meshgrid1 = predict(Cross_Validation1.Trained{1},XGrid1);

gscatter(xx1(:), xx2(:), predictions_meshgrid1,'rgb');
hold on
training_data1 = data(training(Partition1),:);

Y1 = ismember(training_data1.WorldRank,labels{1});

scatter(training_data1.Population2024(Y1),training_data1.Population2023(Y1), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data1.Population2024(~Y1),training_data1.Population2023(~Y1) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Population_2024');
ylabel('Population_2023');

title(classifier_name);
hold off;
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 2

figure;
classifier_name = 'Decision Tree Model 2 (Training)';

Population2024_range_2 = min(data.Population2024(training(Partition2)))-1:0.01:max(data.Population2024(training(Partition2)))+1;
Population2023_range_2 = min(data.Population2023(training(Partition2)))-1:0.01:max(data.Population2023(training(Partition2)))+1;

[xx3, xx4] = meshgrid(Population2024_range_2,Population2023_range_2);
XGrid2 = [xx3(:) xx4(:)];

predictions_meshgrid2 = predict(Cross_Validation2.Trained{1},XGrid2);

gscatter(xx3(:), xx4(:), predictions_meshgrid2,'rgb');
hold on
training_data2 = data(training(Partition2),:);

Y2 = ismember(training_data2.WorldRank,labels{1});

scatter(training_data2.Population2024(Y2),training_data2.Population2023(Y2), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data2.Population2024(~Y2),training_data2.Population2023(~Y2) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Population_2024');
ylabel('Population_2023');

title(classifier_name);
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
hold off;
axis tight 

%% Figure 3

figure;
classifier_name = 'Decision Tree Model 3(Training)';

Population2024_range_3 = min(data.Population2024(training(Partition3)))-1:0.01:max(data.Population2024(training(Partition3)))+1;
Population2023_range_3 = min(data.Population2023(training(Partition3)))-1:0.01:max(data.Population2023(training(Partition3)))+1;

[xx5, xx6] = meshgrid(Population2024_range_3,Population2023_range_3);
XGrid3 = [xx5(:) xx6(:)];

predictions_meshgrid3 = predict(Cross_Validation3.Trained{1},XGrid3);

gscatter(xx5(:), xx6(:), predictions_meshgrid3,'rgb');
hold on
training_data3 = data(training(Partition3),:);

Y3 = ismember(training_data3.WorldRank,labels{1});

scatter(training_data3.Population2024(Y3),training_data3.Population2023(Y3), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data3.Population2024(~Y3),training_data3.Population2023(~Y3) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Population_2024');
ylabel('Population_2023');

title(classifier_name);
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
hold off;
axis tight

%% -------------- Visualizing testing set results ----------------
% ---------------------------- Code ---------------------------
 
%% Figure 1

figure;
classifier_name = 'Decision Tree Model 1(Testing)';

Population2024_range_1 = min(data.Population2024(training(Partition1)))-1:0.01:max(data.Population2024(training(Partition1)))+1;
Population2023_range_1 = min(data.Population2023(training(Partition1)))-1:0.01:max(data.Population2023(training(Partition1)))+1;

[xx1, xx2] = meshgrid(Population2024_range_1,Population2023_range_1);
XGrid1 = [xx1(:) xx2(:)];

predictions_meshgrid1 = predict(Cross_Validation1.Trained{1},XGrid1);

gscatter(xx1(:), xx2(:), predictions_meshgrid1,'rgb');
hold on
testing_data1 =  data(test(Partition1),:);

Y1 = ismember(testing_data1.WorldRank,labels{1});

scatter(testing_data1.Population2024(Y1),testing_data1.Population2023(Y1), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data1.Population2024(~Y1),testing_data1.Population2023(~Y1) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Population_2024');
ylabel('Population_2023');

title(classifier_name);
legend off, 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 2

figure;
classifier_name = 'Decision Tree Model 2(Testing)';

Population2024_range_2 = min(data.Population2024(training(Partition2)))-1:0.01:max(data.Population2024(training(Partition2)))+1;
Population2023_range_2 = min(data.Population2023(training(Partition2)))-1:0.01:max(data.Population2023(training(Partition2)))+1;

[xx3, xx4] = meshgrid(Population2024_range_2,Population2023_range_2);
XGrid2 = [xx3(:) xx4(:)];

predictions_meshgrid2 = predict(Cross_Validation2.Trained{1},XGrid2);

gscatter(xx3(:), xx4(:), predictions_meshgrid2,'rgb');
hold on
testing_data2 = data(test(Partition2),:);

Y2 = ismember(testing_data2.WorldRank,labels{1});

scatter(testing_data2.Population2024(Y2),testing_data2.Population2023(Y2), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data2.Population2024(~Y2),testing_data2.Population2023(~Y2) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Population_2024');
ylabel('Population_2023');

title(classifier_name);
legend off, 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

%% Figure 3

figure;
classifier_name = 'Decision Tree Model 3(Testing)';

Population2024_range_3 = min(data.Population2024(training(Partition3)))-1:0.01:max(data.Population2024(training(Partition3)))+1;
Population2023_range_3 = min(data.Population2023(training(Partition3)))-1:0.01:max(data.Population2023(training(Partition3)))+1;

[xx5, xx6] = meshgrid(Population2024_range_3,Population2023_range_3);
XGrid3 = [xx5(:) xx6(:)];

predictions_meshgrid3 = predict(Cross_Validation3.Trained{1},XGrid3);

gscatter(xx5(:), xx6(:), predictions_meshgrid3,'rgb');
hold on
testing_data3 = data(test(Partition3),:);

Y3 = ismember(testing_data3.WorldRank,labels{1});

scatter(testing_data3.Population2024(Y3),testing_data3.Population2023(Y3), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data3.Population2024(~Y3),testing_data3.Population2023(~Y3) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

xlabel('Population_2024');
ylabel('Population_2023');

title(classifier_name);
legend off, 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
axis tight

 %view(Cross_Validation.Trained{1},'Mode','Graph')