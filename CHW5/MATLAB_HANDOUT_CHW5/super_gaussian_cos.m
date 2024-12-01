function amplitude = super_gaussian_cos(coordinates, sigma, center)
    % Shift the coordinates so that (0,0) is where CENTER is in the original coordinates
    coordinates_shifted = coordinates; % Copy the original coordinates
    coordinates_shifted(:,:,1) = coordinates_shifted(:,:,1) - center(1);
    coordinates_shifted(:,:,2) = coordinates_shifted(:,:,2) - center(2);
    
    % Calculate the square radius by summing the x coordinate and y coordinate, squared, for each point
    r_squared = sum(coordinates_shifted.^2, 3);
    
    % Calculate the amplitude
    amplitude = exp(-(r_squared.^2) / sigma^4) .* cos(4 * sqrt(r_squared) / sigma);
end