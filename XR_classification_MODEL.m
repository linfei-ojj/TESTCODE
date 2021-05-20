clc;
close all;
clear all;
load([ 'E:\data_1']);
load([ 'E:\data_0']);

[M1 N1] = size(data_1);
[M2 N1] = size(data_0);
data=[data_1;data_0];
data2=load('E:\XR_SFS1_SVM_TEZHENG.mat');
data3=data;
fff=data2.fff;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
label = [ones(M1, 1); zeros(M2, 1)];
len=length(label);
index=[1:len]';
cv=5;
  for i = 1:cv
   index_1= index(1:M1);index_0= index(M1+1:end);
   test_ind_1  = index_1([floor((i-1)*M1/cv)+1:floor(i*M1/cv)]');
   test_ind_0 = index_0([floor((i-1)*M2/cv)+1:floor(i*M2/cv)]');
   test_ind = [test_ind_1;test_ind_0 ];
   train_ind = index;
   train_ind(test_ind) = [];
   testData=data3(test_ind ,:);
   testLabel=label(test_ind );
   trainData=data3(train_ind,:);
   trainLabel=label(train_ind);
   cols=fff;
   data1=data3(:,cols);
   traindata=data1(train_ind,:);
   testdata=data1(test_ind,:);

%%%%%%%%%%%%%%%%%%%%%% svm
           model = libsvmtrain(trainLabel,traindata,'-b 0');
           [predicted_label, accuracy,decisionvalue] = libsvmpredict(testLabel ,testdata, model,'-b 0');
           predicted_label_all(test_ind)=predicted_label;
           decisionvalue_all(test_ind)=decisionvalue(:,1);
%%%%%%%%%%%%%%%%%%%%%%% bayes
%              nb = ClassificationNaiveBayes.fit(traindata, trainLabel);
%             [predicted_label,decisionvalue]= predict(nb, testdata);  
%             decisionvalue_all(test_ind)=decisionvalue(:,2);
%             predicted_label_all(test_ind)=predicted_label;
%%%%%%%%%%%%%%%%%%%%%%% adaboostm1
%             ens = fitensemble(traindata,trainLabel,'AdaBoostM1',100,'tree','type','classification');
%             [predicted_label,decisionvalue]= predict(ens, testdata);
%             decisionvalue_all(test_ind)=decisionvalue(:,2);
%             predicted_label_all(test_ind)=predicted_label;
%%%%%%%%%%%%%%%%%%%%%%% gentleboost
%              ens = fitensemble(traindata,trainLabel,'GentleBoost',100,'tree','type','classification');
%             [predicted_label,decisionvalue]= predict(ens, testdata);  
%             decisionvalue_all(test_ind)=decisionvalue(:,2);
%             predicted_label_all(test_ind)=predicted_label;
%%%%%%%%%%%%%%%%%%%%%%% logitboost
%              ens = fitensemble(traindata,trainLabel,'LogitBoost',100,'tree','type','classification');
%             [predicted_label,decisionvalue]= predict(ens, testdata);  
%             decisionvalue_all(test_ind)=decisionvalue(:,2);
%             predicted_label_all(test_ind)=predicted_label;
%%%%%%%%%%%%%%%%%%%%%%% robustboost
%             ens = fitensemble(traindata,trainLabel,'RobustBoost',100,'tree','type','classification');
%             [predicted_label,decisionvalue]= predict(ens, testdata);  
%             decisionvalue_all(test_ind)=decisionvalue(:,2);
%             predicted_label_all(test_ind)=predicted_label;
%%%%%%%%%%%%%%%%%%%%%%% random forest
%             B = TreeBagger(50,traindata,trainLabel);
%             [predicted_label,decisionvalue]= predict(B, testdata); 
%             decisionvalue_all(test_ind)=decisionvalue(:,2);
%             predicted_label_all(test_ind)=str2num(cell2mat(predicted_label));
  end
  decisionvalue_all=decisionvalue_all';
 [accuracy,sensitivity,specificity,auc,TP,TN,FP,FN] = classifyPerform(predicted_label_all',label,decisionvalue_all);%计算评价指标
 aresult=[accuracy,sensitivity,specificity,auc,TP,TN,FP,FN];


