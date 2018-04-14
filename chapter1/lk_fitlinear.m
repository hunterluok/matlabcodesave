x = [1;3;5];
t = [4.8;11.1;17.2];
N = length(x);

m_x = sum(x)/N;
m_t = sum(t)/N;

m_xt = sum(x.*t)/N;
m_xx = sum(x.*x)/N;

w_1 = (m_xt-m_x*m_t)/(m_xx - m_x.*m_x);
w_0 = m_t - m_x * w_1;

figure(1);
hold off
plot(x,t,'bo','markersize',10,'linewidth',2)
xplot=[0,6]
xlim(xplot)
hold on
figure(2);
plot(xplot,w_0+w_1 * xplot,'r','linewidth',2)
xlabel('x');
ylabel('t');
title('xxx');
