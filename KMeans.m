%%--------------------- KMeans Clustering ------------------------
%%--------------------- Importing Dataset ------------------------
% ---------------------------- Code ------------------------------
data = readtable('C:\Users\adity\Documents\MATLAB\Mall_customers.csv'); 
data = data(:,4:5);
data = table2array(data);

%%------------------ Visualizing the Dataset ---------------------
% ---------------------------- Code ------------------------------
scatter(data(:,1),data(:,2),15,'blue','filled');


%%------------  Selecting Optimal Number of Clusters ------------
% ------------------- Using the Elbow Method --------------------
% ---------------------------- Code -----------------------------

WCSS = [];
for k = 1:10
    [idx,C,sumd] = kmeans(data,k,'MaxIter',100,'Start','plus','Replicates',5); 
    WCSS(k) = sum(sumd);
end 

plot(1:10, WCSS); 
title('The Elbow Method');
xlabel('Number of Clusters');
ylabel('WCSS')


%%---------------------- Clustering data ------------------------
% ---------------------------- Code -----------------------------

[idx,C] = kmeans(data,5,'MaxIter',100,'Start','plus','Replicates',5); 
unique(idx)


%%------------------ Visualizing the Clusters -------------------
% ---------------------------- Code -----------------------------

figure, 
gscatter(data(:,1),data(:,2),idx);
hold on
scatter(C(:,1),C(:,2) ,100, 'black','filled');
legend({'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5'})
title('Clustering results on the dataset');
xlabel('Annual Income');
ylabel('Spending Scores')
hold off
