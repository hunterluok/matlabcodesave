clear all;
close all
N1 =100;
N2 =28;

x=[randn(N1,2);randn(N2,2)+2];
t=[repmat(0,N1,1);repmat(1,N2,1)];
N=size(x,1);
col = {'ko','ks'};
%col={'r','b'};
fc = {[ 0 0 0],[1 1 1]};
tv = unique(t);
figure(1); 
hold off

for i = 1:length(tv)
    pos = find(tv(i)==t);
    plot(x(pos,1),x(pos,2),col{i},'markerfacecolor',fc{i});
    grid on
    hold on
end

Nfold = 10;
Kvals = [1:5:30];
Nrep = 100;
Errors= zeros(length(Kvals),Nfold,Nrep);

for rep=1:Nrep
    order=randperm(N);
    Nfold = 10;
    sizes = repmat(floor(N/Nfold),1,Nfold);
    sizes(end) = sizes(end)+N-sum(sizes);
    csizes= [0 cumsum(sizes)];
    
    for kv = 1:length(Kvals)
        K=Kvals(kv);
        for fold = 1:Nfold
            trainX=x;
            traint=t;
            foldindex = order(csizes(fold)+1:csizes(fold+1));
            trainX(foldindex,:)=[];
            traint(foldindex)=[];
            testX = x(foldindex,:);
            testt= t(foldindex);
            
            classes =zeros(size(testX,1),1);
            for i =1:size(testX,1)
                this = testX(i,:);
                dists = sum((trainX-repmat(this,size(trainX,1),1)).^2,2);
                [d I]=sort(dists);
                [a b]=hist(traint(I(1:K)),unique(t));
                pos = find(a==max(a));
                if length(pos)>1 % choose a class randomly;
                    temp_order = randperm(length(pos));
                    pos = pos(temp_order(1));
                end
                classes(i) =b(pos);
            end
            Errors(kv,fold,rep)=sum(classes~=testt);
        end
    end
end

figure(1);
hold off
s= sum(sum(Errors,3),2)./(N*Nrep);
plot(Kvals,s);
xlabel('K');
ylabel('Errir');
title('kfold-knn');
text(15,0.08,'I get it,happy');