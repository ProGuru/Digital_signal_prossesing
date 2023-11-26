% вариант 2
f1 = 40;
f2 = 120;
T = 0.25; % время действия сигнала
dt = 0.001; % интервал дискредитации

fs = 1/dt; % частота дискретизации (s = sample) = 1/0,0.001 = 1 кГц

N = fix(T/dt); % число отсчетов в реализации (перевод в целое число)
t = 0:dt:(N-1)*dt; % вектор дискретизации по времени
n = 0:1:(N-1); % array of counts
df = 1 / T; % интервал дискретизации (= 4 Гц)
f = n * df; % recovered freq

x1 = sin(2*pi*f1*t); % return a vector x of sinus - non odd
x2 = sin(2*pi*f2*t); % return a vector x of sinus - non odd
x3 = sin(2*pi*f1*t) + cos(2*pi*f2*t)-(-1+1.*rand(1,N));

X3 = fft(x3); % спектр сигнала х (ДПФ)

xv3 = ifft(X3); % восстановленная по спектру последовательность (ОДПФ)

diff = x3.-xv3;

subplot(311), plot(t,x1,'-b;x1(t);'), hold on, plot(t,x2,'-r;x2(t);'), hold on,
plot(t,x3,'-k;x3(t);'), title('Сложный сигнал и его составляющие'), xlabel('с'), grid minor;

subplot(312), plot(f,abs(X3),'-g;abs(X1(f);'), title('Спектр сигнала'), xlabel('Гц'), grid minor;
subplot(313), plot(f,real(xv3),'-m;real(xv3);'), title('Восстановленный спектр'), xlabel('n'), grid minor;
