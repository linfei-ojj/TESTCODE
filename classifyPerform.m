function [accuracy,sensitivity,specificity,auc,TP,TN,FP,FN] = classifyPerform(response,Y,decisionvalue)


TP = sum(response==1 & Y==1);
TN = sum(response==0 & Y==0);
FP = sum(response==1 & Y==0);
FN = sum(response==0 & Y==1);


sensitivity = TP/(TP + FN);
specificity = TN/(TN + FP);
accuracy = (TP + TN)/(TP + TN + FP + FN);
auc = roc_curve(decisionvalue,Y);
end
      
function auc = roc_curve(decisionvalue,label_y)
  [val,ind] = sort(decisionvalue,'descend');
	roc_y = label_y(ind);
	stack_x = cumsum(roc_y == 0)/sum(roc_y ==0);
	stack_y = cumsum(roc_y == 1)/sum(roc_y == 1);
	auc = sum((stack_x(2:length(roc_y),1)-stack_x(1:length(roc_y)-1,1)).*stack_y(2:length(roc_y),1))     

	plot(stack_x,stack_y);
  hold on
  plot([0,1],[0,1],'--r');
	xlabel('False Positive Rate');
	ylabel('True Positive Rate');
	title(['ROC curve of (AUC = ' num2str(auc) ' )']);
end