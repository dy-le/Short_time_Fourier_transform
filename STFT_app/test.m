Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector


[x1, f1, t1] = random_signal(Fs, L)
[x2, f2, t2] = random_signal(Fs, L)
[x3, f3, t3] = random_signal(Fs, L)

x = x1 + x2 + x3
figure(1)
plot(t, x)

% define analysis parameters
wlen = 128;                        % window length (recomended to be power of 2)
hop = wlen/4;                      % hop size (recomended to be power of 2)
nfft = 2048;                       % number of fft points (recomended to be power of 2)

% perform STFT
win = blackman(wlen, 'periodic');
[S, f, t] = STFT(x, wlen, hop, nfft, Fs);

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

figure(2)
surf(t, f, S)
shading interp
axis tight
view(0, 90)
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time, s')
ylabel('Frequency, Hz')
title('Amplitude spectrogram of the signal')
hcol = colorbar;
set(hcol, 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel(hcol, 'Magnitude, dB')