%clc; clear;
pkg load signal; % для работы с impz
% Вариант 2
% коэффициенты для 2-го варианта
b = 2.5;
a = -0.6;
a1 = -0.6;
a2 = 0.4;

% коэффициенты для системы 1-го порядка:
B = [b 0];
A = [1 a];

% коэффициенты для системы 2-го порядка:
B1 = [b 0 0];
A1 = [1 a1 a2]; % например y′′ − 6y′ - 6y = 0

% data from lab1
T = 0.05; % изменено с 0,25 на 0,05 для наилучшей наглядности
dt = 0.001; % интервал дискретизации
f1 = 40;
f2 = 120;

% signal vector
fs = 1/dt; % частота дискретизации
df = 1/T; % частота полосы обзора
N = fix(T/dt);
t = 0:dt:(N-1)*dt;
k = 0:1:(N-1);
f = 0:df:fs;

% отсчеты входного сигнала
randX = -1 + 2.*rand(1,N); % генерируются раномные числа в массиве [1 N] от 0 до 2 со смещением -1
x = sin(2*pi*f1*t) + cos(2*pi*f2*t) - randX; % complex
X = fft(x); % спектр входного сигнала X(k)= ДПФ(x(n));

% impz для плоскости Z; В - коэфф. числителя, А - коэфф. знаменателя
[h1,t] = impz(B,A,N,fs); % находим импульсную характеристику фильтра 1-го порядка
[h2,t] = impz(B1,A1,N,fs); % находим импульсную характеристику фильтра 2-го порядка

H1 = fft(h1); % Частотная характеристика ЛПП-системы H(k)= ДПФ(h(n));
H2 = fft(h2); % Частотная характеристика ЛПП-системы H(k)= ДПФ(h(n));

% Функция filter из методички. Для решения линейных разностных уравнений с постоянными коэффициентами
% Функция filter использует Рациональную Передаточную Функцию
% Обеспечивает воспроизведение выходной последовательности y(n) по известной
% входной последовательности x(n) и векторам коэффициентов B,A : y=filter(B,A,x)
y1 = filter(B,A,x); % применяется для обработки КИХ и БИХ фильтров
y2 = filter(B1,A1,x); % применяется для обработки КИХ и БИХ фильтров

% Спектр выходной последовательности ЛПП-системы Yk=ДПФ[y(n)]
% связан со спектром входной последовательности Xk=ДПФ[x(n)] отображением свертки
% в частотной области: Yk=HkXk
y1_1 = ifft(X.*H1');
y2_1 = ifft(X.*H2');

Y1 = fft(y1); % спектр входного сигнала y1
Y2 = fft(y2); % спектр входного сигнала y2


figure; % -	во временной области:
subplot(411), plot(t,x,'-k;x;'), title('Входной сигнал x(t)'), xlabel('c'), grid minor;
subplot(412), plot(t,y1,'-b;y1;'), title('Выходной сигнал y1 с использованием разностного уравнения'), xlabel('с'), grid minor;
subplot(413), plot(abs(y1_1),'-c;abs(y1_1);'), title('Реакция системы на заданный сигнал x(n)'), xlabel('n'), grid minor;
subplot(414), plot(abs(y1-y1_1),'-m;abs(y1-y1_1);'), title(' y - output signal freq'), xlabel('n'), grid minor;
legend ("sin (x)");

pause; % -	во временной области:
subplot(411), plot(t,x,'-k;x;'), text('132465'), title('Входной сигнал x(t)'), xlabel('c'), grid minor;
subplot(412), plot(t,y2,'-b;y2;'), title('Выходной сигнал y2 с использованием разностного уравнения'), xlabel('c'), grid minor;
subplot(413), plot(abs(y2_1),'-c;abs(y2_1);'), title(' y - output signal impulse'), xlabel('n'), grid minor;
subplot(414), plot(abs(y2-y2_1),'-m;abs(y2-y2_1);'), title(' y - output signal freq'), xlabel('n'), grid minor;

pause; % - в частотной области:
subplot(411), plot(h1,'-g;h1;'), title('Импульсная характеристика h1'), xlabel('n'), grid minor;
subplot(412), plot(abs(X),'-k;abs(X);'), title('Cпектр входного сигнала ДПФ(x(n))'), xlabel('n'), grid minor;
subplot(413), plot(abs(Y1),'-b;abs(Y1);'), title('Cпектр выходного сигнала ДПФ(y1(n))'), xlabel('n'), grid minor;
subplot(414), plot(abs(H1),'-r;abs(H1);'), title('Частотная характеристика ДПФ(h1(n))'), xlabel('n'), grid minor;

pause; % - в частотной области:
subplot(411), plot(h2,'-g;h2;'), title('Импульсная характеристика h2'), xlabel('с'), grid minor;
subplot(412), plot(abs(X),'-k;abs(X);'), title('Cпектр входного сигнала ДПФ(x(n))'), xlabel('n'), grid minor;
subplot(413), plot(abs(Y2),'-b;abs(Y2);'), title('Cпектр выходного сигнала ДПФ(y2(n))'), xlabel('n'), grid minor;
subplot(414), plot(abs(H2),'-r;abs(H2);'), title('Частотная характеристика ДПФ(h2(n))'), xlabel('n'), grid minor;
