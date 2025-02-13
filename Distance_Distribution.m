%% Accuracy, Precision, Recall, F1_Score

    TP1=50;
    TN1=18;
    FP1=5;
    FN1=7;

    TP2=47;
    TN2=16;
    FP2=7;
    FN2=10;

    TP3=49;
    TN3=16;
    FP3=10;
    FN3=5;

    TP4=53;
    TN4=0;
    FP4=0;
    FN4=27;

    TP5=42;
    TN5=13;
    FP5=8;
    FN5=17;

    TP6=44;
    TN6=22;
    FP6=5;
    FN6=9;

    TP7=48;
    TN7=27;
    FP7=1;
    FN7=4;

    TP8=36;
    TN8=7;
    FP8=16;
    FN8=21;

    % TP9=57;
    % TN9=0;
    % FP9=0;
    % FN9=23;

    TP10=51;
    TN10=23;
    FP10=2;
    FN10=4;

    Accuracy1=(TP1+TN1)/(TP1+TN1+FP1+FN1);
    Accuracy2=(TP2+TN2)/(TP2+TN2+FP2+FN2);
    Accuracy3=(TP3+TN3)/(TP3+TN3+FP3+FN3);
    Accuracy4=(TP4+TN4)/(TP4+TN4+FP4+FN4);
    Accuracy5=(TP5+TN5)/(TP5+TN5+FP5+FN5);
    Accuracy6=(TP6+TN6)/(TP6+TN6+FP6+FN6);
    Accuracy7=(TP7+TN7)/(TP7+TN7+FP7+FN7);
    Accuracy8=(TP8+TN8)/(TP8+TN8+FP8+FN8);
    % Accuracy9=(TP9+TN9)/(TP9+TN9+FP9+FN9);
    Accuracy10=(TP10+TN10)/(TP10+TN10+FP10+FN10);

    Precision1=TP1/(TP1+FP1);
    Precision2=TP2/(TP2+FP2);
    Precision3=TP3/(TP3+FP3);
    Precision4=TP4/(TP4+FP4);
    Precision5=TP5/(TP5+FP5);
    Precision6=TP6/(TP6+FP6);
    Precision7=TP7/(TP7+FP7);
    Precision8=TP8/(TP8+FP8);
    % Precision9=TP9/(TP9+FP9);
    Precision10=TP10/(TP10+FP10);

    Recall1=TP1/(TP1+FN1);
    Recall2=TP2/(TP2+FN2);
    Recall3=TP3/(TP3+FN3);
    Recall4=TP4/(TP4+FN4);
    Recall5=TP5/(TP5+FN5);
    Recall6=TP6/(TP6+FN6);
    Recall7=TP7/(TP7+FN7);
    Recall8=TP8/(TP8+FN8);
    % Recall9=TP9/(TP9+FN9);
    Recall10=TP10/(TP10+FN10);

    F1_Score1=2*((Precision1*Recall1) /(Precision1 +Recall1));
    F1_Score2=2*((Precision2*Recall2) /(Precision2 +Recall2));
    F1_Score3=2*((Precision3*Recall3) /(Precision3 +Recall3));
    F1_Score4=2*((Precision4*Recall4) /(Precision4 +Recall4));
    F1_Score5=2*((Precision5*Recall5) /(Precision5 +Recall5));
    F1_Score6=2*((Precision6*Recall6) /(Precision6 +Recall6));
    F1_Score7=2*((Precision7*Recall7) /(Precision7 +Recall7));
    F1_Score8=2*((Precision8*Recall8) /(Precision8 +Recall8));
    % F1_Score9=2*((Precision9*Recall9) /(Precision9 +Recall9));
    F1_Score10=2*((Precision10*Recall10) /(Precision10 +Recall10));

    x=[0.7000,0.7500,0.6375,0.5875,0.6125,0.7250;0.8750,0.8333,0.8696,0.5875,0.7458,0.9815;
    0.7424,0.8594,0.6349,1,0.7333,0.7162;0.8033,0.8462,0.7339,0.7402,0.7395,0.8281];
    figure
    bar(x)

    y=[0.4000,0.6500,0.6500;0.8125,0.6582,0.9057;0.3824,0.9811,1;0.5200,0.7879,0.7742];
    figure
    bar(y)
   