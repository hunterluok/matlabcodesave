
clear all;close all;
load ../data/olympics

x = male100(:,1);
t = male100(:,2);

x = x -x(1);
x = x./4;

mu0=[0;0];
si0=[100 0;0 5];
ss = 2;

%path(path,'../utilities');
% w = gausssamp(mu0,si0,10);
w =[ normrnd(0,100,[10 1]) normrnd(0,5,[10 1])];
X = [x.^0 x.^1];
figure(1);
hold off
plot(x,t,'bo','markersize',10);
hold on
xl = xlim;
yl = ylim;
for i = 1:10
    plot(x,X*w(i,:)','r');
end
xlim(xl);
ylim(yl);

dord = [3:3:length(x)];
for i =1:length(dord)
    Xsub = X(1:dord(i),:);
    tsub = t(1:dord(i));
    siw = inv((1/ss)*Xsub'*Xsub +inv(si0));
    muw = siw*((1/ss)*Xsub'*tsub + inv(si0)*mu0);
    figure(1);
    hold off
    plot(x,t,'bo','markersize',10);
    hold on
    xl=xlim;
    yl=ylim;
    plot(x,X*muw,'k','linewidth',2);
    wsamp = [normrnd(muw(1),siw(1),[10 1]) normrnd(muw(2),siw(2),[10 1])];
    for j =1:10
        plot(x,X*wsamp(j,:)','r');
    end
    
    xlim(xl);
    ylim(yl);
    legend('data','posterior mean','samples')
    xlabel('olympic number');
    ylabel('winning time');

    [Xv Yv]=meshgrid(9:0.02:13,-0.5:0.02:0.5);
    
    const = (1/sqrt(2*pi))^2;
    const_prior = const./sqrt(det(si0));
    const = const./sqrt(det(siw));
    
    temp=[Xv(:)-muw(1) Yv(:)-muw(2)];
    temp_prior = [Xv(:)-mu0(1) Yv(:)-mu0(2)];
    
    pdfv = const*exp(-0.5*diag(temp*inv(siw)*temp'));
    pdfv = reshape(pdfv,size(Xv));
    
    pdfv_prior = const*exp(-0.5*diag(temp_prior*inv(si0)*temp_prior'));
    pdfv_prior = reshape(pdfv_prior,size(Xv));
    
    figure(2);
    hold off
    contour(Xv,Yv,pdfv,'color','k');
    figure(2);hold on
    contour(Xv,Yv,pdfv_prior,'color',[0.6 0.6 0.6]);
    legend('posterior','prior');

end

    
    
    
        



