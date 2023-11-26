clc; clear;
% variant 1
b  =  1.5; a  = -0.8;
a1 = -1.1; a2 =  0.6;
% система второго порядка
B1=[b 0]; A1=[1 a];
B2=[b 0 0];  A2=[1 a1 a2];
% data from lab1
T=0.062; dt=0.001; f1=20; f2 = 100;
% signal vector
fs=1/dt; df=1/T; N=fix(T/dt);
t=0:dt:(N-1)*dt;
k=0:1:(N-1);
f=0:df:fs;

% отсчеты входного сигнала
x=sin(2*pi*f1*t)+cos(2*pi*f2*t)-(-1+1.*rand(1,N)); % complex
h = filter(B1,A1,[1 zeros(1,N-1)]); %- импульсную характеристику h(n);
X = fft(x); %- спектр входного сигнала X(k)= ДПФ(x(n));
[h1,t] = impz(B1,A1,N,fs);
[h2,t] = impz(B2,A2,N,fs);
H1 = fft(h1); %- частотную  характеристику  H(k)= ДПФ(h(n));
H2 = fft(h2); %- частотную  характеристику  H(k)= ДПФ(h(n));
y1 = filter(B1,A1,x); % через разностные уравнения
y2 = filter(B1,A1,x); % через разностные уравнения
y1_1=ifft(X.*H1');
y2_1=ifft(X.*H2');
Y1=fft(y1); % находим вектор отчетов спектра для сигнала y1
Y2=fft(y2); % находим вектор отчетов спектра для сигнала y2

figure; % -	во временной области:
subplot(411), plot(x,'g'), title(' x - input signal');
subplot(412), plot(y1,'g'), title(' y - output signal subst');
subplot(413), plot(abs(y1_1),'g'), title(' y - output signal impulse');
subplot(414), plot(abs(y1-y1_1),'g'), title(' y - output signal freq');

%pause;
subplot(411), plot(x,'g'), title(' x - input signal');
subplot(412), plot(y2,'g'), title(' y - output signal subst');
subplot(413), plot(abs(y2_1),'g'), title(' y - output signal impulse');
subplot(414), plot(abs(y2-y2_1),'g'), title(' y - output signal freq');

%pause; % - в частотной области:
subplot(421), plot(x,'g'), title('x');
subplot(422), plot(y1,'g'), title('y');
subplot(4,2,[3,4]), plot(h1,'g'), title('h');
subplot(425), plot(abs(X),'g'), title('X - input signal spectre');
subplot(426), plot(abs(Y1),'g'), title('Y - output signal spectre');
subplot(4,2,[7,8]), plot(abs(H1),'g'), title('H - frequency val');

pause; % - в частотной области:
subplot(421), plot(x,'g'), title('x');
subplot(422), plot(y2,'g'), title('y');
subplot(4,2,[3,4]), plot(h2,'g'), title('h');
subplot(425), plot(abs(X),'g'), title('X - input signal spectre');
subplot(426), plot(abs(Y2),'g'), title('Y - output signal spectre');
subplot(4,2,[7,8]), plot(abs(H2),'g'), title('H - frequency val');
