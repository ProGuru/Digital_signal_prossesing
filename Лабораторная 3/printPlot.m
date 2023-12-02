% функция рисует графики
function retval = printPlot (B, A, f, x, N, t, filterName)
  filteredSignal = filter(B, A, x); % решение разностного уравнения
  amplitudeFrequencyResponse = freqz(B, A, length(f)); % вычисление частотной характеристики
  h_impulseResponse = impz(B, A, N); % вычисление импульсной характеристики
%{
Тот же самый результат бы был при использовании следующих строк для вычисления импульсной характеристики:
u0 = [1 zeros(1,N-1)]; % Дельта-функция
h_butter = filter(Bb, Ab, u0); % Импульсная характеристика
%}

  figure;
  subplot(421), plot(t, x,'-m;x(t);'),  title('Входной сигнал'), xlabel('с'), grid minor
  subplot(422), plot(f, abs(fft(x)),'-g;abs(fft(x));'), title('Спектр входного сигнала'), xlabel('Гц'), grid minor;

  subplot(4,2,[3 4]), plot(t, h_impulseResponse,'-k;h_impulseResponse;'), title(strcat('Импульсная характеристика фильтра', filterName)), xlabel('с'), grid minor;
  subplot(4,2,[5 6]), plot(f, abs(amplitudeFrequencyResponse),'-r;abs(amplitudeFrequencyResponse));'), title(strcat('АЧХ фильтра', filterName)), xlabel('Гц'), grid minor;

  subplot(427), plot(t, filteredSignal,'-;filteredSignal;'),  title(strcat('Отфильтрованный фильтром', filterName, ' сигнал')), xlabel('с'), grid minor
  subplot(428), plot(f, abs(fft(filteredSignal)),'-g;abs(fft(filteredSignal));'), title(strcat('Спектр отфильтрованного фильтром', filterName, ' сигнал')), xlabel('Гц'), grid minor;
endfunction
