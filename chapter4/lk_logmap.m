clear all;
close all;
load ../data/logregdata

figure(1);
hold off
plot(X(1:20,1),X(1:20,2),'ko','markersize',10,'markerfacecolor','k')
hold on
plot(X(21:40,1),X(21:40,2),'ks','markersize',10,'linewidth',2)

w = repmat(0,2,1);
tol = 1e-6;
Nits=100;
w_all = zeros(Nits,2);
ss=10;
change =inf;
it = 0;

while change>tol & it<Nits
    prob_t = 1./(1+exp(-X*w));
    
    grad = -(1/ss)*w'+sum(X.*(repmat(t,1,length(w))-repmat(prob_t,1,length(w))),1);
    
    H = -X'*diag(prob_t.*(1-prob_t))*X;
    H = H- (1/ss)*eye(length(w));
    w = w- inv(H)*grad';
    it = it+1;
    w_all(it,:)=w';
    
    if it>1
        change = sum((w_all(it,:)-w_all(it-1,:)).^2);
    end
end

w_all(it+1:end,:)=[];
figure(1);hold off
plot(w_all);
xlabel('Iterations');
ylabel('w');

figure(1); hold off
plot(X(1:20,1),X(1:20,2),'ko','markersize',10,'markerfacecolor','k')
hold on
plot(X(21:40,1),X(21:40,2),'ks','markersize',10,'linewidth',2)
[Xv ,Yv] =meshgrid(-5:0.1:5,-5:0.1:5);

probs =1./(1+exp(-w(1).*Xv-w(2).*Yv));
[cs,h] =contour(Xv,Yv,probs);
clabel(cs,h);
fprintf('\n prob are prob of belong to square class');


    