# Short-time Fourier transform

The final project of the Digital Signal Processing Course (DGT301)

The Short-time Fourier transform (STFT), is a Fourier-related transform used to determine the sinusoidal frequency and phase content of local sections of a signal as it changes over time. In practice, the procedure for computing STFTs is to divide a longer time signal into shorter segments of equal length and then compute the Fourier transform separately on each shorter segment. This reveals the Fourier spectrum on each shorter segment. One then usually plots the changing spectra as a function of time, known as a spectrogram or waterfall plot.

## Forward STFT
---

### Continuous-time STFT

Simply, in the continuous-time case, the function to be transformed is multiplied by a window function which is nonzero for only a short period of time. The Fourier transform (a one-dimensional function) of the resulting signal is taken as the window is slid along the time axis, resulting in a two-dimensional representation of the signal. Mathematically, this is written as:

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle \mathbf {STFT} \{x(t)\}(\tau ,\omega )\equiv X(\tau ,\omega )=\int _{-\infty }^{\infty }x(t)w(t-\tau )e^{-i\omega t}\,dt}">

where <img src="https://render.githubusercontent.com/render/math?math={\displaystyle w(\tau )}"> is the window function, commonly a Hann window or Gaussian window centered around zero, and `x(t)` is the signal to be transformed (note the difference between the window function `w` and the frequency <img src="https://render.githubusercontent.com/render/math?math={\displaystyle \omega }">). <img src="https://render.githubusercontent.com/render/math?math={\displaystyle X(\tau ,\omega )}"> is essentially the Fourier Transform of <img src="https://render.githubusercontent.com/render/math?math={\displaystyle x(t)w(t-\tau )}">, a complex function representing the phase and magnitude of the signal over time and frequency. Often phase unwrapping is employed along either or both the time axis,
<img src="https://render.githubusercontent.com/render/math?math={\displaystyle \tau }"> , and frequency axis, <img src="https://render.githubusercontent.com/render/math?math={\displaystyle \omega }">, to suppress any jump discontinuity of the phase result of the STFT. The time index <img src="https://render.githubusercontent.com/render/math?math={\displaystyle \tau }"> is normally considered to be "slow" time and usually not expressed in as high resolution as time `t`.

### Discrete-time STFT

In the discrete time case, the data to be transformed could be broken up into chunks or frames (which usually overlap each other, to reduce artifacts at the boundary). Each chunk is Fourier transformed, and the complex result is added to a matrix, which records magnitude and phase for each point in time and frequency. This can be expressed as:

<img src="https://render.githubusercontent.com/render/math?math=\mathbf {STFT} \{x[n]\}(m,\omega )\equiv X(m,\omega )=\sum _{n=-\infty }^{\infty }x[n]w[n-m]e^{-j\omega n}">

likewise, with signal x[n] and window w[n]. In this case, m is discrete and ω is continuous, but in most typical applications the STFT is performed on a computer using the Fast Fourier Transform, so both variables are discrete and quantized.

The magnitude squared of the STFT yields the spectrogram representation of the Power Spectral Density of the function:

<img src="https://render.githubusercontent.com/render/math?math=\operatorname spectrogram \{x(t)\}(\tau ,\omega )\equiv |X(\tau ,\omega )|^{2}">

### Sliding DFT

If only a small number of ω are desired, or if the STFT is desired to be evaluated for every shift m of the window, then the STFT may be more efficiently evaluated using a sliding DFT algorithm.

## Inverse STFT

The STFT is invertible, that is, the original signal can be recovered from the transform by the Inverse STFT. The most widely accepted way of inverting the STFT is by using the overlap-add (OLA) method, which also allows for modifications to the STFT complex spectrum. This makes for a versatile signal processing method, referred to as the overlap and add with modifications method.

### Continuous-time STFT

Given the width and definition of the window function w(t), we initially require the area of the window function to be scaled so that

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle \int _{-\infty }^{\infty }w(\tau )\,d\tau =1}">

It easily follows that

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle \int _{-\infty }^{\infty }w(t-\tau )\,d\tau =1\quad \forall \ t}">

and

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle x(t)=x(t)\int _{-\infty }^{\infty }w(t-\tau )\,d\tau =\int _{-\infty }^{\infty }x(t)w(t-\tau )\,d\tau}">

The continuous Fourier Transform is

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle X(\omega )=\int _{-\infty }^{\infty }x(t)e^{-j\omega t}\,dt}">

Substituting x(t) from above:

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle X(\omega )=\int _{-\infty }^{\infty }\left[\int _{-\infty }^{\infty }x(t)w(t-\tau )\,d\tau \right]\,e^{-j\omega t}\,dt}">

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle \qquad=\int _{-\infty }^{\infty }\int _{-\infty }^{\infty }x(t)w(t-\tau )\,e^{-j\omega t}\,d\tau \,dt.}">

Swapping order of integration:

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle X(\omega )=\int _{-\infty }^{\infty }\int _{-\infty }^{\infty }x(t)w(t-\tau )\,e^{-j\omega t}\,dt\,d\tau}">

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle \qquad=\int _{-\infty }^{\infty }\left[\int _{-\infty }^{\infty }x(t)w(t-\tau )\,e^{-j\omega t}\,dt\right]\,d\tau }">

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle \qquad=\int _{-\infty }^{\infty }X(\tau ,\omega )\,d\tau .}">

So the Fourier Transform can be seen as a sort of phase coherent sum of all of the STFTs of x(t). Since the inverse Fourier transform is

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle x(t)={\frac {1}{2\pi }}\int _{-\infty }^{\infty }X(\omega )e^{+j\omega t}\,d\omega}">

then x(t) can be recovered from X(τ,ω) as

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle x(t)={\frac {1}{2\pi }}\int _{-\infty }^{\infty }\int _{-\infty }^{\infty }X(\tau ,\omega )e^{+j\omega t}\,d\tau \,d\omega}">

or

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle x(t)=\int _{-\infty }^{\infty }\left[{\frac {1}{2\pi }}\int _{-\infty }^{\infty }X(\tau ,\omega )e^{+j\omega t}\,d\omega \right]\,d\tau .}">

It can be seen, comparing to above that windowed "grain" or "wavelet" of x(t) is

<img src="https://render.githubusercontent.com/render/math?math={\displaystyle x(t)w(t-\tau )={\frac {1}{2\pi }}\int _{-\infty }^{\infty }X(\tau ,\omega )e^{+j\omega t}\,d\omega .}">

the inverse Fourier transform of X(τ,ω) for τ fixed.

