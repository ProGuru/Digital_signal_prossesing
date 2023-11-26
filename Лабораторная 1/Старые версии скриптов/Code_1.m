% вариант 2
f1 = 40;
f2 = 120;
T = 0.25; % время действия сигнала
dt = 0.001; % интервал дискредитации

fs = 1/dt; % частота дискретизации (s = sample) = 1/0,0.001 = 1 кГц
f1 = 40; %40, 80, 110

N = fix(T*1.2/dt); % число отсчетов в реализации (перевод в целое число)
t = 0:dt:(N-1)*dt; % вектор дискретизации по времени
n = 0:1:(N-1); % array of counts
df = 1 / T; % интервал дискретизации (= 4 Гц)
f = n * df; % recovered freq

x = sin(2*pi*f1*t); % return a vector x of sinus - non odd

X=fft(x); % спектр сигнала х (ДПФ)

p1 = sum(x.^2)/N; % равенство персиваля
p2 = sum(abs(X).^2)/(N^2);

if (round(10^4*p1)/10^4 == round(10^4*p2)/10^4) % округляем до 0,0001
  printf("Равенство Персиваля выполняется, p1 = %d, p2 = %d", p1, p2);
else
  printf("Равенство Персиваля НЕ выполняется, p1 = %d, p2 = %d", p1, p2);
endif

xv=ifft(X); % восстановленная по спектру последовательность (ОДПФ)
diff = x.-xv; % разница между реальным и восстанвленным сигналом

t_orign = 0:0.000005:T; % для построения заданной частоты

subplot(411), plot(t_orign,sin(2*pi*f1*t_orign),'-k;x(t);'),  title('Исходный сигнал'), xlabel('с'), grid minor
subplot(412), plot(x,'-k;x(n);'), title('Частота сигнала по дискретным отсчётам dt'), xlabel('n'), grid minor;
subplot(413), plot(real(xv),'-m;real(xv);'), title('Восстановленный сигнал'), xlabel('n'), grid minor;
subplot(414), plot(real(diff),'-c;real(diff);'), title('Погрешность при восстановлении'), xlabel('n'), grid minor;

printf("\n"); % пустая операция для точки останова

subplot(311), plot(f,real(X),'-r;real(X(f));'), title('Действительная составляющая спектра'), xlabel('Гц'), grid minor;
subplot(312), plot(f,imag(X),'-b;imag(X(f));'), title('Мнимая составляющая спектра'), xlabel('Гц'), grid minor;
subplot(313), plot(f,abs(X),'-g;abs(X(f);'), title('Составляющая спектра по модулю'), xlabel('Гц'), grid minor;
