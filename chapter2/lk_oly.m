
clear all;
close all;
load ../data/olympics

x = male100(:,1);
t = male100(:,2);

x = x-x(1);
x = x./4;

orders=[1 8];
X = [];
N=length(x);

for i = 1:length(orders)
    X = [X x.^orders(i)];
    w = inv(X'*X)*X'*t;
    ss = (1/N) * (t'*t-t'*X*w);
    % log_like(i) = sum(log(normpdf(t,X*w,sqrt(ss))));
    log_like(i) = sum(log(normpdf(t,X*w,sqrt(ss))));
    
    
end

figure(1);
hold off
plot(orders,log_like,'k');
xlabel('model order');
ylabel('log likelihood');
