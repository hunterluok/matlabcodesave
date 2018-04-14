clear all;
close all;

N=100;
x = 10*rand(N,1)-5;
t = 5*x.^3 -x.^2 +x +150 *randn(size(x));

testx = [-5:0.01:5]';
testt = 5 *testx.^3 -testx.^2 +testx + 150*randn(size(testx));

maxorder =7;
X =[];

testX = [];
K=10;

sizes = repmat(floor(N/K),1,K);
sizes(end) =sizes(end)+N-sum(sizes); % ?????????
csizes = [0 cumsum(sizes)];  %?? ? 0???????

for k =0:maxorder
    X = [X x.^k];
    testX = [testX testx.^k];
    
    for fold = 1:K
        foldX =X(csizes(fold)+1:csizes(fold+1),:);
        trainX = X;
        
        trainX(csizes(fold)+1:csizes(fold+1),:)=[];
        foldt = t(csizes(fold)+1:csizes(fold+1));
        
        traint=t;
        traint(csizes(fold)+1:csizes(fold+1))=[];
        
        w = inv(trainX'*trainX)*trainX'*traint;
        
        fold_pred = foldX *w;
        cv_loss(fold,k+1) = mean((fold_pred-foldt).^2);
        
        ind_pred = testX*w;
        ind_loss(fold,k+1) = mean((ind_pred-testt).^2);
        
        train_pred = trainX*w;
        train_loss(fold,k+1) = mean((train_pred-traint).^2);
    end
end
%%
figure(1);
subplot(131)
plot(0:maxorder,mean(cv_loss,1),'linewidth',2)  %1 ???? ???2???????
xlabel('model order');
ylabel('Loss');
title('CV loss');

subplot(132)
plot(0:maxorder,mean(train_loss,1),'linewidth',2)
xlabel('model order');
ylabel('loss');
title('train loss');

subplot(133)
plot(0:maxorder,mean(ind_loss,1),'linewidth',2)
xlabel('model order');
ylabel('loss');
title('independent test loss');

%%
        