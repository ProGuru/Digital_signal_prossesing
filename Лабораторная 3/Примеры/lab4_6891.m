%�������� ������
%clear all;
%clc;
dt=0.001;
T=0.25;
F1=20;
F2=100;
fs=1/dt;
N=T/dt;
df=fs/N;

Wn = 0.707;% ������� �����
f=[0 Wn Wn 1];
H=[1 1 0 0] ;

%������������ �������
t=0:dt:(N-1)*dt;
x=sin(2*pi*F1*t)+sin(2*pi*F2*t);%(rand(1,N)-0.5)*1;% ������� ������


%========== ����������� ������ ����������� ==================
[Bb,Ab]=butter(3,Wn);
Yb=filter(Bb,Ab,x);

figure(1)
Hz_butter=freqz(Bb,Ab);
 %title('ACH FCH Butter');
h_butter = impz(Bb, Ab, N);
imp = [1; zeros(N-1,1)];
h = filter(Bb,Ab,imp);
H = fft(h);

figure(2)
subplot(131), plot(f,(h_butter),'g'), title('ICH');
subplot(132), plot(f,abs(Hz_butter),'g'), title('ACH');
subplot(133), plot(f,phase(h),'g'), title('FCH');

figure(3)
subplot(221),  plot(t,x,'g',t,Yb), title('Signal in');
subplot(222),  plot(t,Yb,'g'),  title('Signal out');
subplot(223),  plot(f,abs(fft(x)),'g'),  title('spectr in');
subplot(224),  plot(f,abs(fft(Yb)),'g'),  title('spectr out');


%========== ����������������� yulewalk ==================


[By,Ay]=yulewalk(3,F,H);
Yy=filter(By,Ay,x);

hy = filter(By,Ay,imp);
Hy = fft(hy);

figure(4)
h_yulewalk=impz(By,Ay,N);%���������� ��������������
Hz_yulewalk=freqz(By,Ay);%���

subplot(121), plot(f,(h_yulewalk),'g'), title('ICH');
subplot(122), plot(f,abs(Hz_yulewalk),'g'), title('ACH');

figure(5)
subplot(223),  plot(t,x,'g',t,Yy), title('Signal in');
subplot(224),  plot(t,Yy,'g'),  title('Signal out');
subplot(225),  plot(f,abs(fft(x)),'g'),  title('spectr in');
subplot(226),  plot(f,abs(fft(Yy)),'g'),  title('spectr out');

%========== ������������� ������ fir1 ==================
bf1=fir1(11,Wn);
Yf1=filter(bf1,1,x);

hf1 = filter(bf1,1,imp);
Hf1 = fft(hf1);

figure(6)
h_fir1=impz(bf1,1,11);
freqz(bf1,1);
subplot(121), plot(f,(h_fir1),'g'), title('ICH');
subplot(122), plot(f,abs(Hz_fir1),'g'), title('ACH');

figure(7)
subplot(321),  plot(t,x,'g',t,Yf1), title('������� ������');
subplot(322),  plot(t,Yf1,'g'),  title('�������� ������');
subplot(323),  plot(f,abs(fft(x)),'g'),  title(' ��');
subplot(324),  plot(f,abs(fft(Yf1)),'g'),  title(' ���');





