function Ap = propagate_fresnel_transfer_2d(coordinates, A, photon_lambda, L)
    % Calculate the delta of the grid, extracted from the provided coordinates
    % Generate the 2D frequency space coordinates that form the transfer function
    dx = abs(coordinates(1, 1, 1) - coordinates(1, 2, 1));
    fs_2d = generate_2d_coordinates(size(coordinates, 2), 1 / dx);

    % Analytically calculate the Fresnel transfer function by Fourier transform of the impulse response (spherical wave)
    H_fresnel = fftshift(exp(1i * 2 * pi / photon_lambda * L) .* ...
        exp(-1i * pi * photon_lambda * L * sum(fs_2d .^ 2, 3)));

    % Multiply the FFT of A and the transfer function to propagate
    Ap = ifftshift(ifft2(fft2(fftshift(A)) .* H_fresnel));

    % Normalize
    Ap = Ap / sqrt(sum(sum(abs(Ap) .^ 2)));

    return
end
