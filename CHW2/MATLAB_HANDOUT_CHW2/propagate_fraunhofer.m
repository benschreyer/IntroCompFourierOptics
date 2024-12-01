function [propagated_coordinates, propagated_amplitude] = propagate_fraunhofer(coordinates, A, lambda, L)
    % scale the input coordinates correctly, length(coordinates) is the number of samples N
    propagated_coordinates = coordinates * lambda * L / (max(coordinates) - min(coordinates))^2 * length(coordinates);
    
    % apply the FFT (fast DFT) to the field to find the diffraction pattern
    % fftshift swaps around the indices of the returned fft from fft, 
    % since the returned indices before fftshift are not in the convenient order
    propagated_amplitude = 1 / (1.0j * lambda * L) * exp(1.0j * 2 * pi / lambda * L) * fftshift(fft(fftshift(A)));
    
    % return the calculated propagation
end