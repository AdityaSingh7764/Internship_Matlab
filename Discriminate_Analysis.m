%% --------------- Importing the dataset -------------------------
% ---------------------------- Code ---------------------------
data = readtable('C:\Users\adity\Documents\MATLAB\Social_Network_Ads.csv');

%% ---------------Data Preprocessing -----------------------------

    Meanage=mean(data.Age,'omitnan');
    Fillage=fillmissing(data.Age,'constant',Meanage);
    data.Age=Fillage;
    Meansalary=mean(data.EstimatedSalary,'omitnan');
    Fillsalary=fillmissing(data.EstimatedSalary,'constant',Meansalary);
    data.EstimatedSalary=Fillsalary;

    
%% -------------- Feature Scalling -------------------------------

% -------------- Method 1: Standardization ----------------------
% ---------------------------- Code -----------------------------

    standardage=(data.Age-mean(data.Age))/std(data.Age);
    data.Age=standardage;
    standardsalary=(data.EstimatedSalary-mean(data.EstimatedSalary))/std(data.EstimatedSalary);
    data.EstimatedSalary=standardsalary;
 
%________________________________________________________________
%________________________________________________________________

%%%%---------------Classifying Data  -----------------------------
%% -------------- Building Classifier ----------------------------
% ---------------------------- Code ---------------------------


Model=fitcdiscr(data,'Purchased~Age+EstimatedSalary');
%please define your classifier here

%% -------------- Test and Train sets ----------------------------
% ---------------------------- Code ---------------------------

cv = cvpartition(Model.NumObservations, 'HoldOut', 0.2);
cross_validated_model = crossval(Model,'cvpartition',cv); 



%% -------------- Making Predictions for Test sets ---------------
% ---------------------------- Code ---------------------------

Predictions = predict(cross_validated_model.Trained{1},data(test(cv),1:end-1));



%% -------------- Analyzing the predictions ---------------------
% ---------------------------- Code ---------------------------

Results = confusionmat(cross_validated_model.Y(test(cv)),Predictions);




%% -------------- Visualizing training set results --------------
%  ---------------------------- Code ---------------------------
 
labels = unique(data.Purchased);
classifier_name = 'Discriminant Analysis (Training Results)';
 % please mention your classifier name here

Age_range = min(data.Age(training(cv)))-1:0.01:max(data.Age(training(cv)))+1;
Estimated_salary_range = min(data.EstimatedSalary(training(cv)))-1:0.01:max(data.EstimatedSalary(training(cv)))+1;

[xx1, xx2] = meshgrid(Age_range,Estimated_salary_range);
XGrid = [xx1(:) xx2(:)];
 
predictions_meshgrid = predict(cross_validated_model.Trained{1},XGrid);
 
gscatter(xx1(:), xx2(:), predictions_meshgrid,'rgb');
 
hold on
 
training_data = data(training(cv),:);
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
classifier_name = 'Discriminant Analysis (Testing Results)';
 % please mention your classifier name here

Age_range = min(data.Age(training(cv)))-1:0.01:max(data.Age(training(cv)))+1;
Estimated_salary_range = min(data.EstimatedSalary(training(cv)))-1:0.01:max(data.EstimatedSalary(training(cv)))+1;

[xx1, xx2] = meshgrid(Age_range,Estimated_salary_range);
XGrid = [xx1(:) xx2(:)];

predictions_meshgrid = predict(cross_validated_model.Trained{1},XGrid);

figure

gscatter(xx1(:), xx2(:), predictions_meshgrid,'rgb');

hold on

testing_data =  data(test(cv),:);
Y = ismember(testing_data.Purchased,labels{1});
 
scatter(testing_data.Age(Y),testing_data.EstimatedSalary(Y), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data.Age(~Y),testing_data.EstimatedSalary(~Y) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');


xlabel('Age');
ylabel('Estimated Salary');

title(classifier_name);
legend off, axis tight

legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');