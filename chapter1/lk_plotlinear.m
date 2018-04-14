clear all;close all;

x = [-5,5];
w0 = [0:1:20];
w1 = [0:0.4:8];

figure(1);
hold off

for i =1:length(w0)
    plot(x,w0(i) +w1(i)*x);
    hold all
    fprintf('\n y=%g+%g x',w0(i),w1(i));
end


figure(2);
hold off
fprintf('\n nKeeps plotting lines on the current')

while 1
    intercept = str2num(input('enter intercept:','s')); % str2num ??????? ?????? ??
    gradient = str2num(input('enter gradient :','s'));
    plot(x,intercept + gradient.*x);
    hold all
    fprintf('\n y=%g+%g x \n\n',intercept,gradient)
end

   
