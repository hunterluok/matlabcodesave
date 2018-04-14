clear all;
close all;

load ../data/olympics.mat

x = male100(:,1);
t = male100(:,2);

x = x-x(1);
x = x./4;

figure(1);
hold off;
plot(x,t,'bo','markersize',10);
xlabel('olympic number (note,not year!)');
ylabel('winning time');


plotx = [x(1)-2:0.01:x(end)+2]';
X=[];
plotX=[];
for k =0:1
    X=[X x.^k];
    plotX=[plotX plotx.^k];
end

w = inv(X'*X)*X'*t;

figure(1);hold off
figure(1);hold off

plot(x,t,'bo','markersize',10);
xlabel('olymic number (note,not_year!)');
ylabel('wining time');
hold on
plot(plotx,plotX*w,'r','linewidth',2)

%% --- quadratic model
plotx =[x(1)-2:0.01:x(end)+2]';
X =[];
plotX=[];
for k=0:2
    X = [X x.^k];
    plotX =[plotX plotx.^k];
end

w= inv(X'*X)*X'*t;

% plot the model
figure(2);hold off  
figure(2);hold off
plot(x,t,'bo','markersize',10);  % ???????????
xlabel('olympic number (note,not year!)');
ylabel('wining time');
hold on
plot(plotx,plotX*w,'r','linewidth',2)

%% ????
plotx = [x(1)-2:0.01:x(end)+2]';  %??????????
X = [];
plotX= [];

for k=0:3
    X=[X x.^k];
    plotX=[plotX plotx.^k];
end

w = inv(X'*X)*X'*t;

figure(3);hold off
figure(3);hold off

plot(x,t,'bo','markersize',10);
xlabel('olympic number (note,not year)');
ylabel('winning time');
hold on
plot(plotx,plotX * w,'r','linewidth',2)

%% 4??
plotx = [x(1)-2:0.01:x(end)+2]';
X = [];
plotX=[];
for k =0:4
    X = [X x.^k];
    plotX =[plotX plotx.^k];
end

w = inv(X'*X)*X'*t;

figure(4);hold off
figure(4);hold off
plot(x,t,'bo','markersize',10);
xlabel('xlabel');
ylabel('ylabel');
hold on
plot(plotx,plotX * w,'r','linewidth',4)

%%  8
plotx =[x(1)-2:0.01:x(end)+2]';
X = [];
plotX = [];

for k=0:3
    X= [X x.^k];
    plotX =[plotX plotx.^k];
end

w = inv(X'*X)*X'*t;

figure(5);hold off
plot(x,t,'bo','markersize',10);
xlabel('x');
ylabel('y');
hold on
plot(plotx,plotX *w,'b','linewidth',2)








