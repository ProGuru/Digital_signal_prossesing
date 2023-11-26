%clc; clear; 
%pkg install -forge control;
%pkg install -forge signal;

% data from lab1
T=0.25; dt=0.001; f1=20; f2=400;
% signal vector
fs=1/dt; df=1/T; N=fix(T/dt); 
t=0:dt:(N-1)*dt; 
k=0:1:(N-1); 
f=0:df:fs; 


% отсчеты входного сигнала
x=sin(2*pi*f1*t)+cos(9*pi*f2*t)-(-1+1.*rand(1,N)); % complex
Wn = 0.707;% частота среза

 [Bb,Ab]=butter(6,Wn); %
 Yb=filter(Bb,Ab,x);
 
 frqbt = freqz(Bb,Ab);
 h_butter = impz(Bb, Ab);
 imp = [1; zeros(N-1,1)];
 sos = filter(Bb,Ab,imp);
 H = fft(h); 
  
 figure;
 subplot(221), plot(h_butter,'g'), title('фильтр Баттерворта'); % фильтр Баттерворта
 subplot(222), plot(abs(frqbt),'g'), title('БИХ фильтр');  % БИХ фильтр
 subplot(223), plot(phasez(Ab,Bb),'g'), title('ФЧХ'); % ФЧХ
 subplot(224), plot(Yb,'g'), title('Filtered'); % разностные уравнения


%========== рекурсивный фильтр Чебышева 1 ==================

 [Bb,Ab]=cheby1(6,0.5,Wn); %
 Yb=filter(Bb,Ab,x);
 
 frqbt = freqz(Bb,Ab);
 h_butter = impz(Bb, Ab, N);
 imp = [1; zeros(N-1,1)];
 h = filter(Bb,Ab,imp);
 H = fft(h); 
  
 figure;
 subplot(221), plot(h_butter,'g'), title('ICH');
 subplot(222), plot(abs(frqbt),'g'), title('ACH');
 subplot(223), plot(phasez(Ab,Bb),'g'), title('FCH');
 subplot(224), plot(Yb,'g'), title('Filtered');

%========== рекурсивный фильтр Чебышева 2 ==================

 [Bb,Ab]=cheby2(6,40,Wn); %
 Yb=filter(Bb,Ab,x);
 
 frqbt = freqz(Bb,Ab);
 h_butter = impz(Bb, Ab, N);
 imp = [1; zeros(N-1,1)];
 h = filter(Bb,Ab,imp);
 H = fft(h); 
  
 figure;
 subplot(221), plot(h_butter,'g'), title('ICH');
 subplot(222), plot(abs(frqbt),'g'), title('ACH');
 subplot(223), plot(phase(Ab,Bb),'g'), title('FCH');
 subplot(224), plot(Yb,'g'), title('Filtered');

%========== рекурсивный фильтр Чебышева 2 ==================
%{
[Bb,Ab]=ellip(6,1,40,Wn); %
Yb=filter(Bb,Ab,x);

frqbt = freqz(Bb,Ab);
h_butter = impz(Bb, Ab, N);
imp = [1; zeros(N-1,1)];
h = filter(Bb,Ab,imp);
H = fft(h); 
 
figure;
subplot(221), plot(h_butter,'g'), title('ICH');
subplot(222), plot(abs(frqbt),'g'), title('ACH');
subplot(223), plot(phase(Ab,Bb),'g'), title('FCH');
subplot(224), plot(Yb,'g'), title('Filtered');
%}
%========== рекурсивный фильтр Чебышева 2 ==================