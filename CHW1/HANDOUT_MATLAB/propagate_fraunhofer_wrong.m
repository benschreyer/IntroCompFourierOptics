function [coordinates, A] = propagate_fraunhofer_wrong(coordinates, A, lambda, L)
    % The propagation is the Fourier transform, so apply the Fourier transform function of MATLAB?
    A = fft(A);
end