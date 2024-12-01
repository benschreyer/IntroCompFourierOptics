function [Ex, Ey] = centroid(coordinates, amplitude)
    % Normalize the amplitude
    amplitude_normalized = normalize(amplitude);
    
    % Calculate the expected value for x
    Ex = sum(coordinates(:,:,1) .* abs(amplitude_normalized).^2, 'all');
    
    % Calculate the expected value for y
    Ey = sum(coordinates(:,:,2) .* abs(amplitude_normalized).^2, 'all');
end