% Using the convolution theorem for discrete Fourier transform (see handout)
function result = circular_convolve(f, g)
    result = ifftshift(ifft(fft(fftshift(f)) .* fft(fftshift(g))));
end