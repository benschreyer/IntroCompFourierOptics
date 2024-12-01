function [Ap] = propagate_fresnel_transfer_2d(coordinates, A, photon_lambda, L)
    % Calculate the delta of the grid, extracted from the provided coordinates
    dx = abs(coordinates(1, 1, 1) - coordinates(1, 2, 1));
    
    % Generate the 2D frequency space coordinates that form the transfer function
    fs_2d = generate_2d_coordinates(size(coordinates, 2), 1 / dx);


    % Calculate the Fresnel transfer function (spherical wave in Fourier space)
    H_fresnel = fftshift(exp(1i * 2 * pi / photon_lambda * L) .* ...
        exp(-1i * pi * photon_lambda * L * sum(fs_2d .^ 2, 3)));


    % Multiply the FFT of A and the transfer function to propagate
    Ap = ifftshift(ifft2(fft2(fftshift(A)) .* H_fresnel));

    % Normalize the propagated field
    Ap = Ap ./ sqrt(sum(sum(abs(Ap) .^ 2)));

    % Return the propagated amplitude and the transfer function
    return
end