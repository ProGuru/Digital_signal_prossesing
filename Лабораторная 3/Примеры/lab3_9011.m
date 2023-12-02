dt = 0.0001;
fs = 1/dt;
T = 0.125;
N=fix(T/dt);
df = fs/N;
fk = 0:df:(N-1)*df;
f0 = 100;
f1 = 2000;

t=0:dt:(N-1)*dt;
x = 2*cos(2*pi*f0*t);
x2 = 2*cos(2*pi*f1*t);
xcomp = 2*cos(2*pi*f0*t) + 2*cos(2*pi*f1*t);

u = zeros(1,length(y));
u(int32(length(u)/2)) = 1;

[B,A] = butter(3, 0.2);

h = filter(B,A,u);

y = filter(B,A,x);
y2 = filter(B,A,x2);
ycomp = filter(B,A,xcomp);

H = fft(h); Y = fft(y); X = fft(y);
y_h = conv(h,x);
Ycomp = fft(ycomp);
Xcomp = fft(xcomp);
% y_s2 = ifft((exp(j*2*pi*fk/fs)).*fft(x));

% subplot(421), plot(t,x,'g'),  title('x_0(t)');
% subplot(422), plot(t,y,'g'),  title('y_0(t)');
subplot(321), plot(fk, abs(Xcomp),'g'),  title('abs(X_{comp}(f))');
subplot(322), plot(fk, abs(Ycomp),'g'),  title('abs(Y_{comp}(f))');
% subplot(424), plot(fk, real(H),'g'),  title('real(H(f))');
% subplot(425), plot(fk, imag(H),'g'),  title('imag(H(f))');
subplot(323), plot(fk, abs(H),'g'),  title('abs(H(f))');
subplot(325), plot(t,xcomp,'g'),  title('x_{comp}(t)');
subplot(326), plot(t,ycomp,'g'),  title('y_{comp}(t)');
pause;

[B,A] = cheby1(3,20,0.2);
h = filter(B,A,u);
Ycomp = fft(ycomp);
Xcomp = fft(xcomp);
H = fft(h);
ycomp = filter(B,A,xcomp);

% subplot(421), plot(t,x,'g'),  title('x_0(t)');
% subplot(422), plot(t,y,'g'),  title('y_0(t)');
subplot(321), plot(fk, abs(Xcomp),'g'),  title('abs(X_{comp}(f))');
subplot(322), plot(fk, abs(Ycomp),'g'),  title('abs(Y_{comp}(f))');
% subplot(424), plot(fk, real(H),'g'),  title('real(H(f))');
% subplot(425), plot(fk, imag(H),'g'),  title('imag(H(f))');
subplot(323), plot(fk, abs(H),'g'),  title('abs(H(f))');
subplot(325), plot(t,xcomp,'g'),  title('x_{comp}(t)');
subplot(326), plot(t,ycomp,'g'),  title('y_{comp}(t)');
pause;

[B,A] = cheby2(3,20,0.2);
h = filter(B,A,u);
H = fft(h);
ycomp = filter(B,A,xcomp);
Ycomp = fft(ycomp);
Xcomp = fft(xcomp);

% subplot(421), plot(t,x,'g'),  title('x_0(t)');
% subplot(422), plot(t,y,'g'),  title('y_0(t)');
subplot(321), plot(fk, abs(Xcomp),'g'),  title('abs(X_{comp}(f))');
subplot(322), plot(fk, abs(Ycomp),'g'),  title('abs(Y_{comp}(f))');
% subplot(424), plot(fk, real(H),'g'),  title('real(H(f))');
% subplot(425), plot(fk, imag(H),'g'),  title('imag(H(f))');
subplot(323), plot(fk, abs(H),'g'),  title('abs(H(f))');
subplot(325), plot(t,xcomp,'g'),  title('x_{comp}(t)');
subplot(326), plot(t,ycomp,'g'),  title('y_{comp}(t)');
