clc;
close all;
clear all;
load([ 'E:\data_1']);
load([ 'E:\data_0']);
[M1 N1] = size(data_1);
[M2 N1] = size(data_0);
data_t=[data_1;data_0];
[c,k]=size(data_t);
[data_t,mean1,variance1]=zscore(data_t);%特征向量标准化
mm=0;
data_te=data_t;
for i=1:k
    if isnan(data_t(1,i))==1;
        data_te(:,i-mm)=[];
        mm=mm+1;
    end
end
jj= 0;
data=data_te;
[c,k]=size(data);
for i = 1:k
     a = data_te(:,i);
     b = all(~(diff(a)));
     if  b == 1
         data(:,i-jj) = [];
         jj = jj + 1;
     end     
end
label = [ones(M1, 1); zeros(M2, 1)];
len=length(label);
index=[1:len]';
[a,b]=size(data);
acc=zeros(2,b);
cv=5;
  for j=1:b
  for i = 1:cv
   index_1= index(1:M1);index_0= index(M1+1:end);
   test_ind_1  = index_1([floor((i-1)*M1/cv)+1:floor(i*M1/cv)]');
   test_ind_0 = index_0([floor((i-1)*M2/cv)+1:floor(i*M2/cv)]');
   test_ind = [test_ind_1;test_ind_0 ];
   train_ind = index;%1;201
   train_ind(test_ind) = [];
   testData=data(test_ind ,:);
   testLabel=label(test_ind );
   trainData=data(train_ind,:);
   trainLabel=label(train_ind);
 cols{i}=[j];
data1=data(:,cols{i});
traindata=data1(train_ind,:);
testdata=data1(test_ind,:);
%%%%%%%%%%%%%%%%%%%%%%% svm
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
 [accuracy,sensitivity,specificity,auc,TP,TN,FP,FN] = classifyPerform(predicted_label_all',label,decisionvalue_all');%计算评价指标

acc(1,j)=accuracy(1,1);
acc(2,j)=j;
accu=acc';
accu=sortrows(accu,-1);
fea=zeros(a,b);
  end

for j=1:b
    for i=1:a
    fea(i,j)=data(i,accu(j,2));
    end
end

clos=[];
acc=-1;
au=0;
sen=0;
spe=0;
for ii=1:b
   clo=ii;
   newclo=clos;
   newclo(end+1)=clo;
for i = 1:cv
   index_1= index(1:M1);index_0= index(M1+1:end);
   test_ind_1  = index_1([floor((i-1)*M1/cv)+1:floor(i*M1/cv)]');
   test_ind_0 = index_0([floor((i-1)*M2/cv)+1:floor(i*M2/cv)]');
   test_ind = [test_ind_1;test_ind_0 ];
   train_ind = index;
   train_ind(test_ind) = [];
   testData=fea(test_ind ,:);
   testLabel=label(test_ind );
   trainData=fea(train_ind,:);
   trainLabel=label(train_ind);
   data1=fea(:, newclo);
   traindata=data1(train_ind,:);
   testdata=data1(test_ind,:);
            model = libsvmtrain(trainLabel,traindata,'-b 0');
           [predicted_label, accuracy,decisionvalue] = libsvmpredict(testLabel ,testdata, model,'-b 0');
           predicted_label_all(test_ind)=predicted_label;
           decisionvalue_all(test_ind)=decisionvalue(:,1);
  end
[accuracy,sensitivity,specificity,auc,TP,TN,FP,FN] = classifyPerform(predicted_label_all',label,decisionvalue_all');
aresult=[accuracy,sensitivity,specificity,auc,TP,TN,FP,FN];
if accuracy>acc
    acc=accuracy;
    au=auc;
    sen=sensitivity;
    spe=specificity;
    clos(end+1)=clo;
    decisionvalue_all1=decisionvalue_all;
    predicted_label_all1=predicted_label_all;
end
end
aresult1=[acc,sen,spe,au];

[m,n]=size(clos);%1*17
    f=0;
    for iii=2:n
        fewclo=clos;
        fewclo(:,iii-f-1)=[];
        for i = 1:cv
            index_1= index(1:M1);index_0= index(M1+1:end);
            test_ind_1  = index_1([floor((i-1)*M1/cv)+1:floor(i*M1/cv)]');
            test_ind_0 = index_0([floor((i-1)*M2/cv)+1:floor(i*M2/cv)]');
            test_ind = [test_ind_1;test_ind_0 ];
            train_ind = index;
            train_ind(test_ind) = [];
            testData=fea(test_ind ,:);
            testLabel=label(test_ind );
            trainData=fea(train_ind,:);
            trainLabel=label(train_ind);
            data1=fea(:, fewclo);
            traindata=data1(train_ind,:);
            testdata=data1(test_ind,:);
            model = libsvmtrain(trainLabel,traindata,'-b 0');
           [predicted_label, accuracy,decisionvalue] = libsvmpredict(testLabel ,testdata, model,'-b 0');
           predicted_label_all2(test_ind)=predicted_label;
           decisionvalue_all2(test_ind)=decisionvalue(:,1);
        end
        [accuracy,sensitivity,specificity,auc,TP,TN,FP,FN] = classifyPerform(predicted_label_all',label,decisionvalue_all');
        aresult=[accuracy,sensitivity,specificity,auc,TP,TN,FP,FN];
        if accuracy>acc
            acc=accuracy;
            au=auc;
            sen=sensitivity;
            spe=specificity;
            clos=fewclo;
            decisionvalue_all3=decisionvalue_all2;
            predicted_label_all3=predicted_label_all2;
            f=f+1;
        end
    end
aresult2=[acc,sen,spe,au];
[x,y]=size(clos);
fff=zeros(x,y);
for j=1:y
    fff(1,j)=accu((clos(1,j)),2);
end

