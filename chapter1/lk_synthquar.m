clear all;
close all;

N=200;
x = 10*(sort(rand(N,1))-0.5);
w_0 = 1;
w_1 = -2;
w_2 = 0.5;

t = w_0 + w_1 * x +w_2 * (x.^2);
t = t + 0.5*randn(N,1);

figure(1);
hold off;
plot(x,t,'k','markersize',10);
xlabel('x');
ylabel('t');

X = [];
for k =0:2
    X=[X x.^k];
    if k==1 
        linear_w = inv(X'*X) * X' *t;
    end
    if k==2
        quad_w = inv(X'*X)*X'*t;
    end
end

fprintf('\n linear function: t=%g+%g x',linear_w(1),linear_w(2));
fprintf('\n Quadratic function: t=%g +%g x +%g x^2',...
    quad_w(1),quad_w(2),quad_w(3));


plotx = [-5:0.01:5]';
plotX = [];
for k = 0:2
    plotX=[plotX plotx.^k];
end

figure(1);
hold off;
plot(x,t,'k.','markersize',10);
xlabel('x');
ylabel('t');
hold on;
plot(plotx,plotX*quad_w,'r','linewidth',2);
plot(plotx,plotX(:,1:2)*linear_w,'g','linewidth',2);

legend('Data','Quadratic','Linear')






