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


Model1=fitcdiscr(data,'Purchased~Age+EstimatedSalary','DiscrimType','linear');
Model2=fitcdiscr(data,'Purchased~Age+EstimatedSalary','DiscrimType','diaglinear');
Model3=fitcdiscr(data,'Purchased~Age+EstimatedSalary','DiscrimType','quadratic');
Model4=fitcdiscr(data,'Purchased~Age+EstimatedSalary','DiscrimType','diagquadratic');
Model5=fitcdiscr(data,'Purchased~Age+EstimatedSalary','DiscrimType','pseudolinear');
Model6=fitcdiscr(data,'Purchased~Age+EstimatedSalary','DiscrimType','pseudoquadratic');

%% -------------- Test and Train sets ----------------------------
% ---------------------------- Code ---------------------------

cv1 = cvpartition(Model1.NumObservations, 'HoldOut', 0.2);
cv2 = cvpartition(Model2.NumObservations, 'HoldOut', 0.2);
cv3 = cvpartition(Model3.NumObservations, 'HoldOut', 0.2);
cv4 = cvpartition(Model4.NumObservations, 'HoldOut', 0.2);
cv5 = cvpartition(Model5.NumObservations, 'HoldOut', 0.2);
cv6 = cvpartition(Model6.NumObservations, 'HoldOut', 0.2);

cross_validated_model1 = crossval(Model1,'cvpartition',cv1);
cross_validated_model2 = crossval(Model2,'cvpartition',cv2);
cross_validated_model3 = crossval(Model3,'cvpartition',cv3);
cross_validated_model4 = crossval(Model4,'cvpartition',cv4);
cross_validated_model5 = crossval(Model5,'cvpartition',cv5);
cross_validated_model6 = crossval(Model6,'cvpartition',cv6);



%% -------------- Making Predictions for Test sets ---------------
% ---------------------------- Code ---------------------------

Predictions1 = predict(cross_validated_model1.Trained{1},data(test(cv1),1:end-1));
Predictions2 = predict(cross_validated_model2.Trained{1},data(test(cv2),1:end-1));
Predictions3 = predict(cross_validated_model3.Trained{1},data(test(cv3),1:end-1));
Predictions4 = predict(cross_validated_model4.Trained{1},data(test(cv4),1:end-1));
Predictions5 = predict(cross_validated_model5.Trained{1},data(test(cv5),1:end-1));
Predictions6 = predict(cross_validated_model6.Trained{1},data(test(cv6),1:end-1));

%% -------------- Analyzing the predictions ---------------------
% ---------------------------- Code ---------------------------

Results1 = confusionmat(cross_validated_model1.Y(test(cv1)),Predictions1);
Results2 = confusionmat(cross_validated_model2.Y(test(cv2)),Predictions2);
Results3 = confusionmat(cross_validated_model3.Y(test(cv3)),Predictions3);
Results4 = confusionmat(cross_validated_model4.Y(test(cv4)),Predictions4);
Results5 = confusionmat(cross_validated_model5.Y(test(cv5)),Predictions5);
Results6 = confusionmat(cross_validated_model6.Y(test(cv6)),Predictions6);

%% -------------- Visualizing training set results --------------
%  ---------------------------- Code ---------------------------

labels = unique(data.Purchased);
classifier_name = 'Discriminant Analysis (Training Results)';
 % please mention your classifier name here

% Model 1

Age_range1 = min(data.Age(training(cv1)))-1:0.01:max(data.Age(training(cv1)))+1;
Estimated_salary_range1 = min(data.EstimatedSalary(training(cv1)))-1:0.01:max(data.EstimatedSalary(training(cv1)))+1;

[xx1, xx2] = meshgrid(Age_range1,Estimated_salary_range1);
XGrid1 = [xx1(:) xx2(:)];
 
predictions_meshgrid1 = predict(cross_validated_model1.Trained{1},XGrid1);
figure
gscatter(xx1(:), xx2(:), predictions_meshgrid1,'rgb');
 
hold on
 
training_data1 = data(training(cv1),:);
Y1 = ismember(training_data1.Purchased,labels{1});
 
 
scatter(training_data1.Age(Y1),training_data1.EstimatedSalary(Y1), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data1.Age(~Y1),training_data1.EstimatedSalary(~Y1) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');
 
 
xlabel('Age');
ylabel('Estimated Salary');
 
title(classifier_name);
legend off, axis tight
 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
 
% Model 2

Age_range2 = min(data.Age(training(cv2)))-1:0.01:max(data.Age(training(cv2)))+1;
Estimated_salary_range2 = min(data.EstimatedSalary(training(cv2)))-1:0.01:max(data.EstimatedSalary(training(cv2)))+1;

[xx3, xx4] = meshgrid(Age_range2,Estimated_salary_range2);
XGrid2 = [xx3(:) xx4(:)];
 
predictions_meshgrid2 = predict(cross_validated_model2.Trained{1},XGrid2);
figure
gscatter(xx3(:), xx4(:), predictions_meshgrid2,'rgb');
 
hold on
 
training_data2 = data(training(cv2),:);
Y2 = ismember(training_data2.Purchased,labels{1});
 
 
scatter(training_data2.Age(Y2),training_data2.EstimatedSalary(Y2), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data2.Age(~Y2),training_data2.EstimatedSalary(~Y2) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');
 
 
xlabel('Age');
ylabel('Estimated Salary');
 
title(classifier_name);
legend off, axis tight
 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');

% Model 3

Age_range3 = min(data.Age(training(cv3)))-1:0.01:max(data.Age(training(cv3)))+1;
Estimated_salary_range3 = min(data.EstimatedSalary(training(cv3)))-1:0.01:max(data.EstimatedSalary(training(cv3)))+1;

[xx5, xx6] = meshgrid(Age_range3,Estimated_salary_range3);
XGrid3 = [xx5(:) xx6(:)];
 
predictions_meshgrid3 = predict(cross_validated_model3.Trained{1},XGrid3);
figure
gscatter(xx5(:), xx6(:), predictions_meshgrid3,'rgb');
 
hold on
 
training_data3 = data(training(cv3),:);
Y3 = ismember(training_data3.Purchased,labels{1});
 
 
scatter(training_data3.Age(Y3),training_data3.EstimatedSalary(Y3), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data3.Age(~Y3),training_data3.EstimatedSalary(~Y3) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');
 
 
xlabel('Age');
ylabel('Estimated Salary');
 
title(classifier_name);
legend off, axis tight
 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');

% Model 4

Age_range4 = min(data.Age(training(cv4)))-1:0.01:max(data.Age(training(cv4)))+1;
Estimated_salary_range4 = min(data.EstimatedSalary(training(cv4)))-1:0.01:max(data.EstimatedSalary(training(cv4)))+1;

[xx7, xx8] = meshgrid(Age_range4,Estimated_salary_range4);
XGrid4 = [xx7(:) xx8(:)];
 
predictions_meshgrid4 = predict(cross_validated_model4.Trained{1},XGrid4);
figure
gscatter(xx7(:), xx8(:), predictions_meshgrid4,'rgb');
 
hold on
 
training_data4 = data(training(cv4),:);
Y4 = ismember(training_data4.Purchased,labels{1});
 
 
scatter(training_data4.Age(Y4),training_data4.EstimatedSalary(Y4), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data4.Age(~Y4),training_data4.EstimatedSalary(~Y4) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');
 
 
xlabel('Age');
ylabel('Estimated Salary');
 
title(classifier_name);
legend off, axis tight
 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');

% Model 5

Age_range5 = min(data.Age(training(cv5)))-1:0.01:max(data.Age(training(cv5)))+1;
Estimated_salary_range5 = min(data.EstimatedSalary(training(cv5)))-1:0.01:max(data.EstimatedSalary(training(cv5)))+1;

[xx9, xx10] = meshgrid(Age_range5,Estimated_salary_range5);
XGrid5 = [xx9(:) xx10(:)];
 
predictions_meshgrid5 = predict(cross_validated_model5.Trained{1},XGrid5);
figure
gscatter(xx9(:), xx10(:), predictions_meshgrid5,'rgb');
 
hold on
 
training_data5 = data(training(cv5),:);
Y5 = ismember(training_data5.Purchased,labels{1});
 
 
scatter(training_data5.Age(Y5),training_data5.EstimatedSalary(Y5), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data5.Age(~Y5),training_data5.EstimatedSalary(~Y5) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');
 
 
xlabel('Age');
ylabel('Estimated Salary');
 
title(classifier_name);
legend off, axis tight
 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');

% Model 6

Age_range6 = min(data.Age(training(cv6)))-1:0.01:max(data.Age(training(cv6)))+1;
Estimated_salary_range6 = min(data.EstimatedSalary(training(cv6)))-1:0.01:max(data.EstimatedSalary(training(cv6)))+1;

[xx11, xx12] = meshgrid(Age_range6,Estimated_salary_range6);
XGrid6 = [xx11(:) xx12(:)];
 
predictions_meshgrid6 = predict(cross_validated_model6.Trained{1},XGrid6);
figure
gscatter(xx11(:), xx12(:), predictions_meshgrid6,'rgb');
 
hold on
 
training_data6 = data(training(cv6),:);
Y6 = ismember(training_data6.Purchased,labels{1});
 
 
scatter(training_data1.Age(Y6),training_data1.EstimatedSalary(Y6), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data1.Age(~Y6),training_data1.EstimatedSalary(~Y6) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');
 
 
xlabel('Age');
ylabel('Estimated Salary');
 
title(classifier_name);
legend off, axis tight
 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
 
%% -------------- Visualizing testing set results ----------------
% ---------------------------- Code ---------------------------
 
labels = unique(data.Purchased);
classifier_name = 'Discriminant Analysis (Testing Results)';
 
% Figure 1

Age_range1 = min(data.Age(training(cv1)))-1:0.01:max(data.Age(training(cv1)))+1;
Estimated_salary_range1 = min(data.EstimatedSalary(training(cv1)))-1:0.01:max(data.EstimatedSalary(training(cv1)))+1;

[xx1, xx2] = meshgrid(Age_range1,Estimated_salary_range1);
XGrid1 = [xx1(:) xx2(:)];

predictions_meshgrid1 = predict(cross_validated_model1.Trained{1},XGrid1);

figure

gscatter(xx1(:), xx2(:), predictions_meshgrid1,'rgb');

hold on

testing_data1 =  data(test(cv1),:);
Y1 = ismember(testing_data1.Purchased,labels{1});
 
scatter(testing_data1.Age(Y1),testing_data1.EstimatedSalary(Y1), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data1.Age(~Y1),testing_data1.EstimatedSalary(~Y1) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');


xlabel('Age');
ylabel('Estimated Salary');

title(classifier_name);
legend off, axis tight

legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');

% Figure 2

Age_range2 = min(data.Age(training(cv2)))-1:0.01:max(data.Age(training(cv2)))+1;
Estimated_salary_range2 = min(data.EstimatedSalary(training(cv2)))-1:0.01:max(data.EstimatedSalary(training(cv2)))+1;

[xx3, xx4] = meshgrid(Age_range2,Estimated_salary_range2);
XGrid2 = [xx3(:) xx4(:)];

predictions_meshgrid2 = predict(cross_validated_model2.Trained{1},XGrid2);

figure

gscatter(xx3(:), xx4(:), predictions_meshgrid2,'rgb');

hold on

testing_data2 =  data(test(cv2),:);
Y2 = ismember(testing_data2.Purchased,labels{1});
 
scatter(testing_data2.Age(Y2),testing_data2.EstimatedSalary(Y2), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data2.Age(~Y2),testing_data2.EstimatedSalary(~Y2) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');


xlabel('Age');
ylabel('Estimated Salary');

title(classifier_name);
legend off, axis tight

legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');

% Figure 3

Age_range3 = min(data.Age(training(cv3)))-1:0.01:max(data.Age(training(cv3)))+1;
Estimated_salary_range3 = min(data.EstimatedSalary(training(cv3)))-1:0.01:max(data.EstimatedSalary(training(cv3)))+1;

[xx5, xx6] = meshgrid(Age_range3,Estimated_salary_range3);
XGrid3 = [xx5(:) xx6(:)];

predictions_meshgrid3 = predict(cross_validated_model3.Trained{1},XGrid3);

figure

gscatter(xx5(:), xx6(:), predictions_meshgrid3,'rgb');

hold on

testing_data3 =  data(test(cv3),:);
Y3 = ismember(testing_data3.Purchased,labels{1});
 
scatter(testing_data3.Age(Y3),testing_data3.EstimatedSalary(Y3), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data3.Age(~Y3),testing_data3.EstimatedSalary(~Y3) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');


xlabel('Age');
ylabel('Estimated Salary');

title(classifier_name);
legend off, axis tight

legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');

% Figure 4

Age_range4 = min(data.Age(training(cv4)))-1:0.01:max(data.Age(training(cv4)))+1;
Estimated_salary_range4 = min(data.EstimatedSalary(training(cv4)))-1:0.01:max(data.EstimatedSalary(training(cv4)))+1;

[xx7, xx8] = meshgrid(Age_range4,Estimated_salary_range4);
XGrid4 = [xx7(:) xx8(:)];

predictions_meshgrid4 = predict(cross_validated_model4.Trained{1},XGrid4);

figure

gscatter(xx7(:), xx8(:), predictions_meshgrid4,'rgb');

hold on

testing_data4 =  data(test(cv4),:);
Y4 = ismember(testing_data4.Purchased,labels{1});
 
scatter(testing_data4.Age(Y4),testing_data4.EstimatedSalary(Y4), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data4.Age(~Y4),testing_data4.EstimatedSalary(~Y4) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');


xlabel('Age');
ylabel('Estimated Salary');

title(classifier_name);
legend off, axis tight

legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');

% Figure 5

Age_range5 = min(data.Age(training(cv5)))-1:0.01:max(data.Age(training(cv5)))+1;
Estimated_salary_range5 = min(data.EstimatedSalary(training(cv5)))-1:0.01:max(data.EstimatedSalary(training(cv5)))+1;

[xx9, xx10] = meshgrid(Age_range5,Estimated_salary_range5);
XGrid5 = [xx9(:) xx10(:)];

predictions_meshgrid5 = predict(cross_validated_model5.Trained{1},XGrid5);

figure

gscatter(xx9(:), xx10(:), predictions_meshgrid5,'rgb');

hold on

testing_data5 =  data(test(cv5),:);
Y5 = ismember(testing_data5.Purchased,labels{1});
 
scatter(testing_data5.Age(Y5),testing_data5.EstimatedSalary(Y5), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data5.Age(~Y5),testing_data5.EstimatedSalary(~Y5) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');


xlabel('Age');
ylabel('Estimated Salary');

title(classifier_name);
legend off, axis tight

legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');

% Figure 6

Age_range6 = min(data.Age(training(cv6)))-1:0.01:max(data.Age(training(cv6)))+1;
Estimated_salary_range6 = min(data.EstimatedSalary(training(cv6)))-1:0.01:max(data.EstimatedSalary(training(cv6)))+1;

[xx11, xx12] = meshgrid(Age_range6,Estimated_salary_range6);
XGrid6 = [xx11(:) xx12(:)];

predictions_meshgrid6 = predict(cross_validated_model6.Trained{1},XGrid6);

figure

gscatter(xx11(:), xx12(:), predictions_meshgrid6,'rgb');

hold on

testing_data6 =  data(test(cv6),:);
Y6 = ismember(testing_data6.Purchased,labels{1});
 
scatter(testing_data6.Age(Y6),testing_data6.EstimatedSalary(Y6), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(testing_data6.Age(~Y6),testing_data6.EstimatedSalary(~Y6) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');


xlabel('Age');
ylabel('Estimated Salary');

title(classifier_name);
legend off, axis tight

legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');