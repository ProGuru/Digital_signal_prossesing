T=0.25;
dt=0.001;
fs=1/dt; % 1000
N=fix(T/dt); % 250
t=0:dt:(N-1)*dt;
n=0:1:(N-1);
 
f=20;
x=cos(2*pi*f*t);
 
b=1.5;
a=-0.8;
B1=[b 0];
A1=[1 a];

h1=[1 ones(1,N-1)];
h2=filter(B1,A1,h1);

data = [1 zeros(1,N-1)];

h=filter(B1,A1,data);
y=filter(B1,A1,x); %выходной сигнал,полученный с помощью разностного уравнения
X=fft(x);
H=fft(h);
Y=fft(y);
%Y=X.*H;
 
y1=conv(h,x); %выходной сигнал,полученный с помощью импульсной характеристики
y2=real(ifft(Y)); %выходной сигнал,полученный c помощью частотной характеристики

figure(1);
subplot(221),plot(x,'g'),title('x(n)');
subplot(222),plot(h,'g'),title('h(n)');
subplot(223),plot(y,'g'),title('y(n)');
subplot(224),plot(h2,'g'),title('h2');
%pause; CLF;
figure(2);
subplot(221),plot(abs(X),'g'),title('X(k)');
subplot(222),plot(abs(H),'g'),title('H(k)');
subplot(223),plot(abs(Y),'g'),title('Y(k)');
figure(3);
subplot(221),plot(y,'g'),title('Y');
subplot(222),plot(y1,'g'),title('Y1');
subplot(223),plot(y2,'g'),title('Y2');