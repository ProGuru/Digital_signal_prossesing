A = [1 -0.8 0.6];
B = [2 0 0];
dt = 0.001;
fs = 1/dt;
T = 0.125;
N=fix(T/dt);
df = fs/N;
fk = 0:df:(N-1)*df;
f0 = 25;

t=0:dt:(N-1)*dt;
x = 2*cos(2*pi*f0*t);

y = filter(B,A,x);
u = zeros(1,length(y));
u(int32(length(u)/2)) = 1;

h = filter(B,A,u);

y_h = conv(h,x);

y_s = ifft(fft(h).*fft(x));
% y_s2 = ifft((exp(j*2*pi*fk/fs)).*fft(x));

subplot(321), plot(t,x,'g'),  title('x(t)');
subplot(323), plot(t,y,'g'),  title('y(t)');
subplot(322), plot(t,h,'g'),  title('h(t)');
subplot(324), plot(y_h,'g'),  title('y_h(t)');
subplot(325), plot(real(y_s),'g'),  title('y_s(t)');

