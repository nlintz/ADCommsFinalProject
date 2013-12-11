function res = plotFFT(signal)
clf
plot(linspace(-pi,pi,length(signal)),abs(fftshift(fft(signal))))
end