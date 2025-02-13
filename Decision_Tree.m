data=readtable('C:\Users\adity\Documents\MATLAB\Social_Network_Ads.csv')

standardage=(data.Age-mean(data.Age))/std(data.Age);
    data.Age=standardage
    standardsalary=(data.EstimatedSalary-mean(data.EstimatedSalary))/std(data.EstimatedSalary);
    data.EstimatedSalary=standardsalary

%% Decision Tree Model Implementation
    %Model=fitctree(data,'Purchased~Age+EstimatedSalary');

    %% No. of splits
    %Model=fitctree(data,'Purchased~Age+EstimatedSalary','MaxNumSplits',7);

    %% Min parent size
    %Model=fitctree(data,'Purchased~Age+EstimatedSalary','MinLeafSize',5);
    
    %% Split Criteria
    Model=fitctree(data,'Purchased~Age+EstimatedSalary','SplitCriterion','gdi');

    % % Test and Train
        Partition=cvpartition(Model.NumObservations,'HoldOut',0.2);
        Cross_Validation=crossval(Model,'cvpartition',Partition);

        Prediction=predict(Cross_Validation.Trained{1}, data(test(Partition), 1:end-1));
    
    %Accuracy checking using confusion matrix
        Results=confusionmat(Cross_Validation.Y(test(Partition)),Prediction);


%% -------------- Visualizing training set results --------------
%  ---------------------------- Code ---------------------------
 
labels = unique(data.Purchased);
classifier_name = 'Decision Tree (Training)';

Age_range = min(data.Age(training(Partition)))-1:0.01:max(data.Age(training(Partition)))+1;
Estimated_salary_range = min(data.EstimatedSalary(training(Partition)))-1:0.01:max(data.EstimatedSalary(training(Partition)))+1;

[xx1, xx2] = meshgrid(Age_range,Estimated_salary_range);
XGrid = [xx1(:) xx2(:)];
 
predictions_meshgrid = predict(Cross_Validation.Trained{1},XGrid);
 
gscatter(xx1(:), xx2(:), predictions_meshgrid,'rgb');
 
hold on
 
training_data = data(training(Partition),:);
Y = ismember(training_data.Purchased,labels{1});
 
 
scatter(training_data.Age(Y),training_data.EstimatedSalary(Y), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data.Age(~Y),training_data.EstimatedSalary(~Y) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');
 
 
xlabel('Age');
ylabel('Estimated Salary');

title(classifier_name);
legend off, axis tight
 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');


%% -------------- Visualizing testing set results ----------------
% ---------------------------- Code ---------------------------
 
labels = unique(data.Purchased);
classifier_name = 'Decision Tree  (Testing)';

Age_range = min(data.Age(training(Partition)))-1:0.01:max(data.Age(training(Partition)))+1;
Estimated_salary_range = min(data.EstimatedSalary(training(Partition)))-1:0.01:max(data.EstimatedSalary(training(Partition)))+1;

[xx1, xx2] = meshgrid(Age_range,Estimated_salary_range);
XGrid = [xx1(:) xx2(:)];

predictions_meshgrid = predict(Cross_Validation.Trained{1},XGrid);

figure

gscatter(xx1(:), xx2(:), predictions_meshgrid,'rgb');

hold on

testing_data =  data(test(Partition),:);
Y = ismember(testing_data.Purchased,labels{1});

scatter(testing_data.Age(Y),testing_data.EstimatedSalary(Y), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data.Age(~Y),testing_data.EstimatedSalary(~Y) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');


xlabel('Age');
ylabel('Estimated Salary');

title(classifier_name);
legend off, axis tight

legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');

 %view(Cross_Validation.Trained{1},'Mode','Graph')