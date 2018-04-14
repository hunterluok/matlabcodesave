
close all;
clear all;

load ../data/kmeansnonlindata

figure(1);
hold off
plot(X(:,1),X(:,2),'ko');

N = size(X,1);
Ke = zeros(N);
gam = 1;


for n1 = 1:N
    for n2 = 1:N
        Ke(n1,n2) = sum(X(n1,:)*X(n2,:)');
        % Ke(n1,n2)=exp(-gam*sum((X(n1,:)-X(n2,:)).^2));
        % ????????? ??  .???? ??? diag(matrix) ? ?? ?? ???????
       % Ke(n1,n2) = exp(-gam*sum(abs(X(n1,:)-X(n2,:)))); %???????
    end
end

converged = 0;
K=2;
Z = repmat([1 0],N,1);
s = sum(X.^2,2);
pos = find(s==min(s));
Z(pos,:) =[0 1];
di = zeros(N,K);

cols = {'r','b'};

figure(1);hold off
for k = 1:K
    pos = find(Z(:,k));
    plot(X(pos,1),X(pos,2),'ko','markerfacecolor',cols{k});
    hold on
end

%%
while ~converged
    Nk = sum(Z,1);
    for k = 1:K
        di(:,k)=diag(Ke)-(2/(Nk(k)))*sum(repmat(Z(:,k)',N,1).*Ke,2)+...
            Nk(k)^(-2)*sum(sum((Z(:,k)*Z(:,k)').*Ke));
        % diag(Ke) ?????? ???
    end
    oldZ =Z;
    Z = (di==repmat(min(di,[],2), 1,K));
    Z = 1.0 *Z;
    if sum(sum(oldZ~=Z))==0
        converged = 1;
    end
    
    figure(1); hold off
    for k=1:K
        pos = find(Z(:,k));
        plot(X(pos,1),X(pos,2),'ko','markerfacecolor',cols{k});
        hold on 
    end
end
%%

