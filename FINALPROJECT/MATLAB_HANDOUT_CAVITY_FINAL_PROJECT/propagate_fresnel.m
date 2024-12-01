function [propagated_coordinates, propagated_amplitude] = propagate_fresnel(coordinates, A, lambda, L)
    % A new propagation, the only change relative to the Fraunhofer propagation is the quadratic phases
    % Scale the input coordinates correctly, length(coordinates) is the number of samples N
    propagated_coordinates = coordinates * lambda * L / (max(coordinates) - min(coordinates))^2 * length(coordinates);
    
    % Apply the FFT (fast DFT) to the field to find the diffraction pattern
    % fftshift swaps around the indices of the returned fft from fft, since the
    % returned indices before fftshift are not in the normal convenient order physicists like to deal with
    
    % Fresnel quadratic phase factors
    B_fp = exp(1i * pi / lambda / L * (propagated_coordinates).^2);
    B_f = exp(1i * pi / lambda / L * (coordinates).^2);

    propagated_amplitude = B_fp .* 1 / (1i * lambda * L) * exp(1i * 2 * pi / lambda * L) .* fftshift(fft(fftshift(A .* B_f)));
    
    % Return the calculated propagation
end