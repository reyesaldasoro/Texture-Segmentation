q1 = min(misclassification,[],1);
q2 = min(misclassification,[],2);
q3 = min(misclassification,[],3);
q4 = min(misclassification,[],4);



%%
qT = min(min(min(misclassification,[],1),[],3),[],4);