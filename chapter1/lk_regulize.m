%%
% l2?????
%%
clear all;
close all;

NN =100;
x = 10 *rand(NN,1)-5;
y = 5*x.^3 - x.^2 + x +150*randn(size(x));

K=10;
orders = [1 2 3 4];

sizes = repmat(floor(NN/K),1,K); % 
sizes(end) = sizes(end) + 100 -sum(sizes);
csizes = [0 cumsum(sizes)];

for i = 1:length(orders)
    X = [];
    for k = 0:orders(i)
        X = [X x.^k];
    end
    
    for fold = 1:K
        foldx= X(csizes(fold)+1:csizes(fold+1),:);
        trainx = X;
        trainx(csizes(fold)+1:csizes(fold+1),:)=[];
        
        foldy = y(csizes(fold)+1:csizes(fold+1),:);
        trainy = y;
        trainy(csizes(fold)+1:csizes(fold+1),:)=[];
        
        nx =size(trainx);
        N = nx(2); % ???????
        w = inv(trainx'*trainx + 0.1* N *eye(size(trainx,2)))*trainx'* trainy;
        
        % ????? eye( size(trainx,2) )
        
        loss(fold,i) = mean((foldx*w-foldy).^2);
    end
end

figure(1);hold off

plot(mean(loss,1),1:length(orders),'r','linewidth',4)
xlabel('$x$','model order')
ylabel('loss');
title('k-fold loss')
%hold on 
%scatter(1:2,mean(loss(1:2,:),2),'b','linewidth',4);