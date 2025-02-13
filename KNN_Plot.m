        TP1=48;
        TN1=9;
        FP1=7;
        FN1=16;
        TP2=50;
        TN2=4;
        FP2=1;
        FN2=25;

        %Accuracy:(TP+TN)/(TP+TN+FP+FN)
        %Precision:TP/(TP+FP)
        %Recall (Sensitivity): TP/(TP+FN)
        %F1_Score: 2*((Precision*Recall) /(Precision +Recall))
       
       x=[0.7125,0.8727,0.7500,0.8067];
       y=[0.6750,0.9804,0.6667,0.7937];
       plot(x)
       hold on
       plot(y)

       % x1=[0.72712,0.99980,0.99982,0.99671;0.46630,0.99978,0.99977,0.99429;0.43571,0.99977,0.99975,0.99379];
       % bar(x1)