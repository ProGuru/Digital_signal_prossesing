% Загрузка аудиофайла
pkg load signal;
audio_name = 'Avicii.mp3'; % вписать вместо Avicii.mp3 название своего музыкального файла
[input_audio, sample_rate] = audioread(audio_name);

% Выбор фильтра
desirable_filter = 'low'; % выбрать high или low

% Определение параметров фильтра
cutoff_frequency = 1000; % Частота среза в Гц (задайте значение по вашему желанию)
order = 4; % Порядок фильтра (задайте значение по вашему желанию)

% Создание фильтра нижних частот Butterworth
[b, a] = butter(order, cutoff_frequency / (sample_rate / 2), desirable_filter);

% Применение фильтра к аудиосигналу
output_audio = filter(b, a, input_audio);

% Вывод спектра обработанного аудио
fft_input = fft(input_audio);
fft_output = fft(output_audio);
frequencies = linspace(0, sample_rate/2, length(fft_input)/2);

% Спектр сигнала
figure(1);
subplot(211), plot(frequencies, fft_input(1:length(fft_input)/2),'-b;input_audio;'), title('Спектр оригинального трека'), xlabel('Частота (Гц)'), ylabel('Амплитуда'), grid minor;
subplot(212), plot(frequencies, fft_output(1:length(fft_output)/2),'-r;output_audio;'), title('Спектр изменённого трека'), xlabel('Частота (Гц)'), ylabel('Амплитуда'), grid minor;

% Сохранение обработанного аудио в новый файл
output_filename = strcat(desirable_filter, '_', 'output_audio.wav'); % только форматы wav, flac, ogg
audiowrite(output_filename, output_audio, sample_rate);

disp(['Обработанный аудио сохранен в файл: ' output_filename]);
