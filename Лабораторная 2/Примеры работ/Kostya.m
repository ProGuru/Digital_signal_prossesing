clc
clear
 
% Ввод исходных данных:
dt=0.0005; % интервал дискретизации (период дискретизации) в секундах
F1=50; % частота сигнала 
T=0.2; % длина сигнала по времени в секундах
 
N=fix(T/dt); % количество отчетов сигналов
fs=1/dt; % частота дискретизации
df=fs/N; % интервал дискретизации по частоте
t=0:dt:(N-1)*dt;
% Задание 1: 
% Формируем исходные сигналы
 
for n=1:N
    x1(n)=cos(2*pi*F1*n*dt); % гармонический сигнал косинусоида с частотой F1 (четная последовательность)
    x2(n)=sin(2*pi*F1*n*dt); % гармонический сигнал синусоида с частотой F2(нечетная последовательность)
end
 
% центрируем сигнал относительно оси времени
x1=x1-mean(x1); % центрируем сигнал относительно оси времени, для этого вычитаем из сигнала его математическое ожидание
x2=x2-mean(x2); % центрируем сигнал относительно оси времени, для этого вычитаем из сигнала его математическое ожидание
 
%=======================================================================================================================
% находим спектр для каждого сигнала (БПФ):
f = [0:fs/N:fs-1]; % вектор частот для БПФ
 
% 1) Делаем прямое и обратное преобразование Фурье для сигнала x1
 
X1=fft(x1); % находим вектор отчетов спектра для сигнала x1 (БПФ), равное числу отчетов сигнала во времени
XX1=[f real(X1) imag(X1) abs(X1)];
p=sum(x1.^2); P=sum(abs(X1).^2); 
x1v=ifft(X1); xx1v=[t x1 x1v];
 
X2=fft(x2); % находим вектор отчетов спектра для сигнала x2 (БПФ), равное числу отчетов сигнала во времени
XX2=[f real(X2) imag(X2) abs(X2)];
p=sum(x2.^2)/N; P=sum(abs(X2).^2)/(N^2); 
x2v=ifft(X2); xx2v=[t x2 x2v];
 
figure
subplot(421), plot(t,x1,'g'),  xlabel('t'), ylabel('x1(t)'), title(' x1'); % график сигнала x1 во временной области
subplot(422), plot(f(1:N/2),abs(X1(1:N/2)),'r'), xlabel('f'), ylabel('abs(X1(f))'),  title('abs(X1(f))'); % построение модуля спектра x1 в частотной области
subplot(423), plot(t,x2,'g'),  xlabel('t'), ylabel('x2(t)'), title(' x2'); % график сигнала x2 во временной области
subplot(424), plot(f(1:N/2),abs(X2(1:N/2)),'r'), xlabel('f'), ylabel('abs(X2(f))'),  title('abs(X2(f))'); % построение модуля спектра x2 в частотной области
