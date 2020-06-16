clear, clc, close all
% load an audio file
[x, fs] = audioread('PinkPanther60.wav');   % load an audio file
x = x(:, 1);                        % get the first channel
% fs = 10e3; % Sample rate
t = 0:1/fs:2; % Sample time
% x = vco(sin(2*pi*t),[0.1 0.4]*fs,fs);
figure(1)
plot(x);
xlabel('Time, s')
ylabel('Amplitude')
title('Original Signal');

% define analysis parameters
wlen = 1024;                        % window length (recomended to be power of 2)
hop = wlen/4;                       % hop size (recomended to be power of 2)
nfft = 4096;                        % number of fft points (recomended to be power of 2)
% perform STFT
win = blackman(wlen, 'periodic'); % hamming
[S, f, t] = stft_edit(x, win, hop, nfft, fs);
% s - Short-time Fourier transform
% f - Frequencies
% t - Time instants
% calculate the coherent amplification of the window
C = sum(win)/wlen;
% take the amplitude of fft(x) and scale it, so not to be a
% function of the length of the window and its coherent amplification
S = abs(S)/wlen/C;
% correction of the DC & Nyquist component
if rem(nfft, 2)                     % odd nfft excludes Nyquist point
    S(2:end, :) = S(2:end, :).*2;
else                                % even nfft includes Nyquist point
    S(2:end-1, :) = S(2:end-1, :).*2;
end
% convert amplitude spectrum to dB (min = -120 dB)
S = 20*log10(S + 1e-6);
% plot the spectrogram
figure(2)
surf(t, f, S)
shading interp
axis tight
view(65, -45)
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time, s')
ylabel('Frequency, Hz')
title('Amplitude spectrogram of the signal')

figure(3)
surf(t, f, S)
shading interp
axis tight
view(90, 90)
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time, s')
ylabel('Frequency, Hz')
title('Amplitude spectrogram of the signal')
hcol = colorbar;
set(hcol, 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel(hcol, 'Magnitude, dB')