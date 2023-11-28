clc; clear;
pkg load signal; % для работы с impz
% Вариант 2
% коэффициенты для 2-го варианта
b = 2.5;
a = -0.6;
a1 = -0.6;
a2 = 0.4;

% коэффициенты для системы 1-го порядка:
B1 = [b 0];
A1 = [1 a];

% коэффициенты для системы 2-го порядка:
B2 = [b 0 0];
A2 = [1 a1 a2]; % например y′′ − 6y′ - 6y = 0

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

%Дельта-функция
u0=[1 zeros(1,N-1)];
u1=[1 ones(1,N-1)];

% Импульсная характеристика ЛПП-системы
% Может быть получена путем решения разностного уравнения при нулевых начальных условиях
% Функция filter использует Рациональную Передаточную Функцию
% Обеспечивает воспроизведение выходной последовательности y(n) по известной
% входной последовательности x(n) и векторам коэффициентов B,A : y=filter(B,A,x)


% для для системы 1-го порядка:
h_1 = filter(B1,A1,u0); % импульсная характеристика
st_1 = filter(B1,A1,u1); % реакция на единичный скачок
y_1 = filter(B1,A1,x); % Выходной сигнал

% для для системы 2-го порядка:
h_2 = filter(B2,A2,u0); % импульсная характеристика
st_2 = filter(B2,A2,u1); % реакция на единичный скачок
y_2 = filter(B2,A2,x); % Выходной сигнал

figure(1); % -	для системы 1-го порядка:

subplot(411), plot(t,x,'-k;x;'), title('Входной сигнал x(t)'), xlabel('c'), grid minor;
subplot(412), plot(t,h_1,'-b;h_1;'), title('Импульсная характеристика ЛПП-системы 1-го порядка'), xlabel('с'), grid minor;
subplot(413), plot(t,st_1,'-m;st_1;'), title('Реакция на единичный скачок'), xlabel('с'), grid minor;
subplot(414), plot(t,y_1,'-c;y_1;'), title('Выходной сигнал'), xlabel('с'), grid minor;

figure(2); % -	для системы 2-го порядка:
subplot(411), plot(t,x,'-k;x;'), title('Входной сигнал x(t)'), xlabel('c'), grid minor;
subplot(412), plot(t,h_2,'-b;h_1;'), title('Импульсная характеристика ЛПП-системы 2-го порядка'), xlabel('с'), grid minor;
subplot(413), plot(t,st_2,'-m;st_1;'), title('Реакция на единичный скачок'), xlabel('с'), grid minor;
subplot(414), plot(t,y_2,'-c;y_1;'), title('Выходной сигнал'), xlabel('с'), grid minor;


X = fft(x); % ДПФ входного сигнала
H_1 = fft(h_1); % Частотная характеристика ЛПП-системы H(k) = ДПФ(импульсная характеристика);
H_2 = fft(h_2); % Частотная характеристика ЛПП-системы H(k) = ДПФ(импульсная характеристика);
Y_1 = fft(y_1); % спектр выходного сигнала y1
Y_2 = fft(y_2); % спектр выходного сигнала y2

% Спектр выходной последовательности ЛПП-системы Yk=ДПФ[y(n)]
% связан со спектром входной последовательности Xk=ДПФ[x(n)] отображением свертки
% в частотной области: Yk=HkXk
Y_k_1 = X.*H_1;
Y_k_2 = X.*H_2;
y_k_1 = ifft(X.*H_1);
y_k_2 = ifft(X.*H_2);

figure(3); % -	для системы 1-го порядка:
subplot(411), plot(abs(X),'-g;abs(X);'), title('Спектр входного сигнала'), xlabel('n'), grid minor;
subplot(412), plot(abs(H_1),'-k;H_1 = abs(fft(h_1));'), title('Спектр частотной характеристики для системы 1-го порядка'), xlabel('n'), grid minor;
subplot(413), plot(abs(Y_1),'-b;abs(Y_1);'), title('Спектр выходного сигнала для системы 1-го порядка'), xlabel('n'), grid minor;
subplot(414), plot(abs(Y_k_1),'-r;Y_k_1=abs(X.*H_1);'), title('Спектр выходного сигнала с использованием частотной характеристики для системы 1-го порядка'), xlabel('n'), grid minor;

figure(4); % -	для системы 2-го порядка:
subplot(411), plot(abs(X),'-g;abs(X);'), title('Спектр входного сигнала'), xlabel('n'), grid minor;
subplot(412), plot(abs(H_2),'-k;H_2 = abs(fft(h_2));'), title('Спектр частотной характеристики для системы 2-го порядка'), xlabel('n'), grid minor;
subplot(413), plot(abs(Y_2),'-b;abs(Y_2);'), title('Спектр выходного сигнала для системы 2-го порядка'), xlabel('n'), grid minor;
subplot(414), plot(abs(Y_k_2),'-r;Y_k_2=abs(X.*H_2);'), title('Спектр выходного сигнала с использованием частотной характеристики для системы 2-го порядка'), xlabel('n'), grid minor;

% Использование формулы свертки
% Функция conv возвращает коэффициенты полинома
y_1_convolution = conv(h_1, x); % выходной сигнал,полученный с помощью импульсной характеристики
y_2_convolution = conv(h_2, x); % выходной сигнал,полученный с помощью импульсной характеристики

figure(5);
subplot(311), plot(abs(y_1),'-b;abs(y_1);'), title('Выходной сигнал, полученный с помощью разностного уравнения для системы 1-го порядка'), xlabel('n'), grid minor;
subplot(312), plot(abs(y_k_1),'-r;abs(y_k_1);'), title("Выходной сигнал, полученный с помощью частотной характеристики для системы 1-го порядка"), xlabel('n'), grid minor;
subplot(313), plot(k,abs(y_1_convolution(1:50),'-g;abs(y_1_convolution);'), title("Выходной сигнал, полученный с импульсной характеристики для системы 1-го порядка"), xlabel('n'), grid minor;

figure(6);
subplot(311), plot(abs(y_2),'-b;abs(y_2);'), title('Выходной сигнал, полученный с помощью разностного уравнения для системы 2-го порядка'), xlabel('n'), grid minor;
subplot(312), plot(abs(y_k_2),'-r;abs(y_k_2);'), title("Выходной сигнал, полученный с помощью частотной характеристики для системы 2-го порядка"), xlabel('n'), grid minor;
subplot(313), plot(k,abs(y_2_convolution(1:50)),'-g;abs(y_2_convolution);'), title("Выходной сигнал, полученный с импульсной характеристики для системы 2-го порядка"), xlabel('n'), grid minor;
