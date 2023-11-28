clc;
clear; 
b=1.5;
a=-0.8;
a1=-1.1;
a2=0.6;
B1=[b 0]; A1=[1 a];
B2=[b 0 0];  A2=[1 a1 a2];
T=0.25;
dt=0.001;
fs=1/dt;
N=fix(T/dt);

t=0:dt:(N-1)*dt;
k=0:1:(N-1);
df=1/T;
f=0:df:fs;
f1=20;

x=sin((2*pi*f1*k)/fs);
h1=filter(B1,A1,[1 zeros(1,N-1)]);
X=fft(x); 
H1=fft(h1); 
Y3=H1.*X;
x=sin((2*pi*f1*k)/fs);
y1=filter(B1,A1,x);
y4=ifft(Y3);
y5=conv(x, h1);

figure(5);
subplot(221), plot(k, y4,'k'), title('spectr: output signal');
subplot(222), plot(k, y1,'k'), title('razn: output signal');
subplot(223), plot(y5,'k'), title('svertka: output signal');
