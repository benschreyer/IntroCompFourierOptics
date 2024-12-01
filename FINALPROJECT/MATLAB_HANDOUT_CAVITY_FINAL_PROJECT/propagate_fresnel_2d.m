function [propagated_coordinates, propagated_amplitude] = propagate_fresnel_2d(coordinates, A, lambda, L)
    % Scale the input coordinates
    propagated_coordinates = coordinates * lambda * L / (max(coordinates(:)) - min(coordinates(:)))^2 * max(size(coordinates));
    
    % Fresnel quadratic phase factors
    B_fp = exp(1.0i * pi / lambda / L * sum(propagated_coordinates.^2, 3));
    B_f = exp(1.0i * pi / lambda / L * sum(coordinates.^2, 3));
    
    % Calculate the propagated amplitude
    propagated_amplitude = B_fp .* (1.0 / (1.0i * lambda * L)) .* exp(1.0i * 2 * pi / lambda * L) .* ...
    fftshift(fft2((A .* B_f)));
    
    % Return the calculated propagation
end